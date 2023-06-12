import numpy as np
import torch

import scipy.ndimage as ndi

def initialise_standard(p, V0, V1, room_length):
	barycenter = centerOfMass(V0, V1, room_length)
	print(f"Initialising sphere with center of mass {barycenter}")
	
	p += barycenter[:, np.newaxis]

def initialise_stdev(p, V0, V1, room_length):
	mu, sigma = centerOfMassAndDeviation(V0, V1, room_length)
	print(f"Initialising sphere with center of mass {mu} and std dev {sigma}")

	p += mu.reshape(-1,1)
	p *= sigma.reshape(-1,1)

def initialise_raymarching(p, V0, V1, room_length):
	mu, _ = centerOfMassAndDeviation(V0, V1, room_length)



def centerOfMass(V0, V1, room_length):
	c0 = np.asarray(ndi.center_of_mass(V0))
	c1 = np.asarray(ndi.center_of_mass(V1))
	c = (c0 + c1) / 2

	return (2 * (c / 256) - 1) * room_length * 1

def centerOfMassAndDeviation(V0, V1, room_length):
	res = V0.shape[0]
	c = np.mgrid[0:res,0:res,0:res].reshape((3, res**3))
	w = (V0 + V1).reshape((1, res**3)).squeeze()

	mu = np.average(c, weights=w, axis=1)
	sigma2 = np.average((c - mu.reshape(-1,1))**2, weights=w, axis=1)
	sigma = np.sqrt(sigma2)

	mu = (2 * (mu / res) - 1) * room_length
	sigma = (sigma / res) * 2 * room_length

	return mu, sigma