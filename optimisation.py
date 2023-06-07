# I have become what I feared the most
# British

import numpy as np
import math
import scipy.optimize as opt
import torch

import matplotlib.pyplot as plt

from scipy.interpolate import interpn
from scipy.ndimage import gaussian_filter

import subsphere_ico

from tqdm import tqdm

import tal

samplingPosition = (np.linspace(0, 255, 256), np.linspace(0, 255, 256), np.linspace(0, 255, 256))

#
# Try cube
# Multiplication instead of sum (Already attempted)
# Weights
# Fair size between vertex
#

def plotSamplingFunction(V, room_length, k=127):
	plt.figure()
	im = np.zeros((256, 256))
	for i in range(256):
		for j in range(256):
			p = np.array([[i], [j], [k]])
			p = (2*(p/256)-1) * room_length
			im[i, j] = sampleVolume(V, p, room_length)
	plt.imshow(im, cmap='hot', interpolation='nearest')
	plt.show()

def optimizeSphere(input_x, input_n, input_neighbours, V0_LOD0, V1_LOD0, input_Vn0, input_Vn1, room_length = 5.0, weight_lods = [1, 0.25, 0.1, 0.05], weight_values = 1, weight_normals = 1, weight_proximity = 1, weight_neighbours = 1, number_of_iterations = 100, save_lod_models=False, subdivisions=1, save_sequence=None, force_cpu = False):
	global samplingPosition

	res = V0_LOD0.shape[0]
	x = np.copy(input_x)
	samplingPosition = (np.linspace(0, res - 1, res), np.linspace(0, res - 1, res), np.linspace(0, res - 1, res))

	print(f"Checking for device...", end='', flush=True)
	dev = torch.device('cpu' if (not torch.cuda.is_available() or force_cpu) else 'cuda')
	print(f" Found: '{dev}'!")
	n = torch.from_numpy(input_n.astype('float64')).to(dev)
	Vn0 = torch.from_numpy(input_Vn0.astype('float64')).to(dev)
	Vn1 = torch.from_numpy(input_Vn1.astype('float64')).to(dev)
	neighbours = torch.clone(input_neighbours).to(dev)
	
	print(f"Generating different LOD versions of the volumes...")
	# Optimise shape of sphere towards probability voxels from 2 views
	V0_LOD1 = gaussian_filter(V0_LOD0, 4, mode='nearest')
	V0_LOD2 = gaussian_filter(V0_LOD0, 32, mode='nearest')
	V0_LOD3 = gaussian_filter(V0_LOD0, 64, mode='nearest')
	V1_LOD1 = gaussian_filter(V1_LOD0, 4, mode='nearest')
	V1_LOD2 = gaussian_filter(V1_LOD0, 32, mode='nearest')
	V1_LOD3 = gaussian_filter(V1_LOD0, 64, mode='nearest')

	#tal.plot.volume(V0_LOD0 + V1_LOD0)

	print(f"Normalising volumes...")
	V0_LOD0 /= np.max(V0_LOD0)
	V0_LOD1 /= np.max(V0_LOD1)
	V0_LOD2 /= np.max(V0_LOD2)
	V0_LOD3 /= np.max(V0_LOD3)
	V1_LOD0 /= np.max(V1_LOD0)
	V1_LOD1 /= np.max(V1_LOD1)
	V1_LOD2 /= np.max(V1_LOD2)
	V1_LOD3 /= np.max(V1_LOD3)

	print(f"Combining all LODs into one...")
	V0 = weight_lods[0] * V0_LOD0 + weight_lods[1] * V0_LOD1 + weight_lods[2] * V0_LOD2 + weight_lods[3] * V0_LOD3
	V1 = weight_lods[0] * V1_LOD0 + weight_lods[1] * V1_LOD1 + weight_lods[2] * V1_LOD2 + weight_lods[3] * V1_LOD3

	#plotSamplingFunction(V0, room_length)

	print(f"Optimising sphere to voxel data for {number_of_iterations} iterations:")
	for i in tqdm(range(number_of_iterations)):
		res = opt.minimize(powerSphere, [x], args=(dev, n, neighbours, V0, V1, Vn0, Vn1, room_length, weight_lods, weight_values, weight_normals, weight_proximity, weight_neighbours), method='CG',
			options={'disp': False, "maxiter": 1}, jac='3-point') #jac=jac_function
		x = unpack(res.x)
		if save_sequence is not None:
			subsphere_ico.save_as_obj(x, subdivisions, f"{save_sequence}/{i}.obj")

	return x, n

def powerSphere(data, device, n, neighbours, V0, V1, Vn0, Vn1, room_length, weights_lods, weight_values, weight_normals, weight_proximity, weight_neighbours):
	x = unpack(data)
	x_torch = torch.from_numpy(x.T).to(device)

	v0 = torch.from_numpy(sampleVolume(V0, x, room_length)).to(device)
	v1 = torch.from_numpy(sampleVolume(V1, x, room_length)).to(device)

	eValue = weights_lods[0] * torch.sum(v0 + v1, dim=0)
	eValue = eValue.item()
	eValue /= (weights_lods[0] + weights_lods[1] + weights_lods[2] + weights_lods[3])

	cos0 = (Vn0 @ n + 1) / 2
	cos1 = (Vn1 @ n + 1) / 2

	eNormal = torch.sum(torch.multiply(v0, cos0) + torch.multiply(v1, cos1))
	eNormal = eNormal.item()
	#eNormal = np.sum(np.multiply(v0.cpu().numpy(), cos0) + np.multiply(v1.cpu().numpy(), cos1))

	# Get distance of every point to every other point
	dists = minDistanceBetweenPoints(x_torch)[0]

	# Energy based on proximity to closest point
	dists_closest = dists[1,:]
	eProximity = -1 * torch.sum(1/(100 * dists_closest))
	eProximity = eProximity.item()

	# Energy based on std dev of neighbours' distances
	n_neighbours = torch.sum(neighbours, dim=0)
	neighbour_dist_mean = torch.sum(dists * neighbours, dim=0) / n_neighbours
	neighbour_dist_stdev = torch.sum(neighbours * (dists - neighbour_dist_mean)**2, dim=0) / n_neighbours #Sigma squared
	eNeighbours = torch.sum(neighbour_dist_stdev)
	eNeighbours = eNeighbours.item()

	return -(weight_values * eValue + weight_normals * eNormal + weight_proximity * eProximity + weight_neighbours * eNeighbours)

def sampleVolume(V, x, room_length):
	global samplingPosition

	res = V.shape[0]

	uvw = res * (x / room_length + 1) / 2
	return interpn(samplingPosition, V, uvw.T, bounds_error=False, fill_value=0)

def unpack(data):
	n = int(np.size(data))
	s = (3, int(n/3))
	return np.resize(data[0:n], s)

def minDistanceBetweenPoints(x):
	dists = torch.cdist(x, x, p=1.0)
	dists = torch.sort(dists, dim=0)
	return dists