# I have become what I feared the most
# British

import numpy as np
import math
import scipy.optimize as opt
import torch

import matplotlib.pyplot as plt

from scipy.interpolate import interpn

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

def optimizeSphere(input_x, input_n, input_neighbours, V0, V1, input_Vn0, input_Vn1, args):
	global samplingPosition

	res = V0.shape[0]
	x = np.copy(input_x)
	samplingPosition = (np.linspace(0, res - 1, res), np.linspace(0, res - 1, res), np.linspace(0, res - 1, res))

	print(f"Checking for device...", end='', flush=True)
	dev = torch.device('cpu' if (not torch.cuda.is_available() or args.cpu) else 'cuda')
	print(f" Found: '{dev}'!")

	n = torch.from_numpy(input_n.astype('float64')).to(dev)
	Vn0 = torch.from_numpy(input_Vn0.astype('float64')).to(dev)
	Vn1 = torch.from_numpy(input_Vn1.astype('float64')).to(dev)
	neighbours = torch.clone(input_neighbours).to(dev)

	print(f"Optimising sphere to voxel data for {args.iterations} iterations:")
	for i in tqdm(range(args.iterations)):
		res = opt.minimize(powerSphere, [x], args=(dev, n, neighbours, V0, V1, Vn0, Vn1, args), method='CG',
			options={'disp': False, "maxiter": 1}, jac='3-point') #jac=jac_function
		x = unpack(res.x)
		if args.sequence is not None:
			subsphere_ico.save_as_obj(x, args.subdivisions, f"{args.sequence}/{i}.obj")

	return x, n

def powerSphere(data, device, n, neighbours, V0, V1, Vn0, Vn1, args):
	x = unpack(data)
	x_torch = torch.from_numpy(x.T).to(device)

	v0 = torch.from_numpy(sampleVolume(V0, x, args.roomsize)).to(device)
	v1 = torch.from_numpy(sampleVolume(V1, x, args.roomsize)).to(device)

	eValue = torch.sum(v0 + v1, dim=0)
	eValue = eValue.item()

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

	return -(args.weightvalues * eValue + args.weightnormals * eNormal + args.weightproximity * eProximity + args.weightneighbours * eNeighbours)

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