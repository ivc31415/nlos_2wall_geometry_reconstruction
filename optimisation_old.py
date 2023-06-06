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
            k = 127
            p = np.array([[i], [j], [k]])
            p = (2*(p/256)-1) * room_length
            im[i, j] = sampleVolume(V, p, room_length)
    plt.imshow(im, cmap='hot', interpolation='nearest')
    plt.show()

def optimizeSphere(x, n, V0, V1, Vn0, Vn1, room_length = 5.0, weight_lods = [1, 0.25, 0.1, 0.05], number_of_iterations = 100, save_lod_models=False, subdivisions=1):
    # Optimise shape of sphere towards probability voxels from 2 views
    V0_LOD1 = gaussian_filter(V0, 4, mode='nearest')
    V0_LOD2 = gaussian_filter(V0, 16, mode='nearest')
    V0_LOD3 = gaussian_filter(V0, 32, mode='nearest')
    V1_LOD1 = gaussian_filter(V1, 4, mode='nearest')
    V1_LOD2 = gaussian_filter(V1, 16, mode='nearest')
    V1_LOD3 = gaussian_filter(V1, 32, mode='nearest')

    #tal.plot.volume(np.abs(V1_LOD1))

    V0s = [V0, V0_LOD1, V0_LOD2, V0_LOD3]
    V1s = [V1, V1_LOD1, V1_LOD2, V1_LOD3]

    print(f"Optimising sphere to voxel data for {number_of_iterations} iterations:")
    for i in tqdm(range(number_of_iterations)):
        res = opt.minimize(powerSphere, [x, n], args=(V0s, V1s, Vn0, Vn1, room_length, weight_lods), method='CG',
            options={'disp': False, "maxiter": 1}, jac='3-point') #jac=jac_function
        x, n = unpack(res.x)

    return x, n

def powerSphere(data, V0s, V1s, Vn0, Vn1, room_length, weights_lods):
    x, n = unpack(data)

    V0_LOD0 = V0s[0]
    V1_LOD0 = V1s[0]

    v0_0 = torch.from_numpy(sampleVolume(V0s[0], x, room_length)).cuda()
    v0_1 = torch.from_numpy(sampleVolume(V0s[1], x, room_length)).cuda()
    v0_2 = torch.from_numpy(sampleVolume(V0s[2], x, room_length)).cuda()
    v0_3 = torch.from_numpy(sampleVolume(V0s[3], x, room_length)).cuda()
    v1_0 = torch.from_numpy(sampleVolume(V1s[0], x, room_length)).cuda()
    v1_1 = torch.from_numpy(sampleVolume(V1s[1], x, room_length)).cuda()
    v1_2 = torch.from_numpy(sampleVolume(V1s[2], x, room_length)).cuda()
    v1_3 = torch.from_numpy(sampleVolume(V1s[3], x, room_length)).cuda()

    eValue = weights_lods[0] * torch.sum(v0_0 + v1_0, dim=0) \
            + weights_lods[1] * torch.sum(v0_1 + v1_1, dim=0) \
            + weights_lods[2] * torch.sum(v0_2 + v1_2, dim=0) \
            + weights_lods[3] * torch.sum(v0_3 + v1_3, dim=0)
    eValue = eValue.item()

    eNormal = np.sum(np.multiply(v0_0.cpu().numpy(), Vn0.T @ n) + np.multiply(v1_1.cpu().numpy(), Vn1.T @ n))

    # eOutlier = 1/np.sum(np.sum(np.subtract(x, c.reshape(-1, 1))**2))

    return -(1 * eValue + 0.25 * eNormal)

def sampleVolume(V, x, room_length):
    global samplingPosition

    uvw = 256 * (x / room_length + 1) / 2
    return interpn(samplingPosition, V, uvw.T, bounds_error=False, fill_value=0)
def unpack(data):
    n = int(np.size(data) / 2)
    s = (3, int(n/3))
    return np.resize(data[0:n], s), np.resize(data[n:(2*n)], s)