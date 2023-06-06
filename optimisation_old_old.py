# I have become what I feared the most
# British

import numpy as np
import math
import scipy.optimize as opt

from scipy.interpolate import interpn
from scipy.ndimage import gaussian_filter

import subsphere_ico

import tal

samplingPosition = (np.linspace(0, 255, 256), np.linspace(0, 255, 256), np.linspace(0, 255, 256))

#
# Try cube
# Multiplication instead of sum (Already attempted)
# Weights
# Fair size between vertex
#

def lsSphere(x, n, V0, V1, Vn0, Vn1, room_length):
    res = opt.least_squares(powerSphere, [x, n], args=(V0, V1, Vn0, Vn1, room_length), method='lm') #jac=jac_function

    return unpack(res.x)

def powerLsSphere(data, V0, V1, Vn0, Vn1, room_length):
    x, n = unpack(data)

    v0 = sampleVolume(V0, x, room_length)
    v1 = sampleVolume(V1, x, room_length)

    c = np.sum(x, 1) / np.shape(x)[1]

    eValue = v0 + v1
    eNormal = np.multiply(v0, Vn0.T @ n) + np.multiply(v1, Vn1.T @ n)
    eOutlier = 1/np.sum(np.sum(np.subtract(x, c.reshape(-1, 1))**4))

    return -(0.2 * eValue + 1 * eNormal - 10 * eOutlier) # Try mult instead of sum

def optimizeSphere(x, n, V0, V1, Vn0, Vn1, room_length, save_lod_models=False, subdivisions=1):
    # Optimise shape of sphere towards probability voxels from 2 views
    V0_LOD1 = gaussian_filter(V0, 4, mode='nearest')
    V0_LOD2 = gaussian_filter(V0, 8, mode='nearest')
    V0_LOD3 = gaussian_filter(V0, 16, mode='nearest')
    V1_LOD1 = gaussian_filter(V1, 4, mode='nearest')
    V1_LOD2 = gaussian_filter(V1, 8, mode='nearest')
    V1_LOD3 = gaussian_filter(V1, 16, mode='nearest')

    #tal.plot.volume(np.abs(V0_LOD1), opacity='linear')

    res1 = opt.minimize(powerSphere, [x, n], args=(V0_LOD3, V1_LOD3, Vn0, Vn1, room_length), method='CG',
                       options={'disp': True, "maxiter": 1}, jac='3-point') #jac=jac_function

    x2, n2 = unpack(res1.x)
    if save_lod_models:
        subsphere_ico.save_as_obj(x2, subdivisions, "output_lod1.obj")

    res2 = opt.minimize(powerSphere, [x2, n2], args=(V0_LOD2, V1_LOD2, Vn0, Vn1, room_length), method='CG',
                       options={'disp': True, "maxiter": 1}, jac='3-point') #jac=jac_function

    x3, n3 = unpack(res2.x)
    if save_lod_models:
        subsphere_ico.save_as_obj(x3, subdivisions, "output_lod2.obj")

    res3 = opt.minimize(powerSphere, [x3, n3], args=(V0_LOD1, V1_LOD1, Vn0, Vn1, room_length), method='CG',
                       options={'disp': True, "maxiter": 1}, jac='3-point') #jac=jac_function

    x4, n4 = unpack(res3.x)
    if save_lod_models:
        subsphere_ico.save_as_obj(x4, subdivisions, "output_lod3.obj")

    res4 = opt.minimize(powerSphere, [x4, n4], args=(V0, V1, Vn0, Vn1, room_length), method='CG',
                       options={'disp': True}, jac='3-point') #jac=jac_function

    return unpack(res4.x)

def powerSphere(data, V0, V1, Vn0, Vn1, room_length):
    x, n = unpack(data)

    v0 = sampleVolume(V0, x, room_length)
    v1 = sampleVolume(V1, x, room_length)

    # c = np.sum(x, 1) / np.shape(x)[1]

    eValue = np.sum(v0 + v1)
    eNormal = np.sum(np.multiply(v0, Vn0.T @ n) + np.multiply(v1, Vn1.T @ n))
    #eBounds = -10000 * np.sum((np.sum(x**2, axis=0) > 2*room_length**2)) #TODO: Don't use a sphere, use the box
    # eOutlier = 1/np.sum(np.sum(np.subtract(x, c.reshape(-1, 1))**2))

    return -(1 * eValue + 0.25 * eNormal)

def sampleVolume(V, x, room_length):
    global samplingPosition

    uvw = 256 * (x / room_length + 1) / 2
    return interpn(samplingPosition, V, uvw.T, bounds_error=False, fill_value=0)

def optimizeTest(x, n):
    # Optimise shape of sphere to be shorter, but still have around
    #   the same volume (calculated with a bounding box)
    maxV = 0.5 # Max Vertical Coordinate
    maxH = math.sqrt(1/maxV) # Max Horizontal Coordnate

    res = opt.minimize(powerTest, [x, n], args=(maxV, maxH), method='CG',
                       options={'disp': True}, jac='3-point') #jac=jac_function

    return unpack(res.x)

def unpack(data):
    n = int(np.size(data) / 2)
    s = (3, int(n/3))
    return np.resize(data[0:n], s), np.resize(data[n:(2*n)], s)

def powerTest(data, maxV, maxH):
    x, n = unpack(data)

    pmax = np.max(x, 1)
    pmin = np.min(x, 1)
    size = np.array([[maxH],[maxH],[maxV]])

    volume = np.prod(pmax - pmin) / 8
    volumeFactor = abs(1 - volume)

    xbox = x / size
    distance = np.sum(xbox**2, 0) # Distance squared
    distanceFactor = abs(1 - np.mean(distance))

    boundsFactor = np.sum((pmax - size)**2) + np.sum((pmin + size)**2)

    return distanceFactor
