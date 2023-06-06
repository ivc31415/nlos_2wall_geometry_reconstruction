import numpy as np
import math

def rot_matrix(angle, axis):
    c = math.cos(angle)
    s = math.sin(angle)
    if axis == 'z':
        return np.array([
            [c, -s, 0],
            [s, c, 0],
            [0, 0, 1]
        ])
    if axis == 'y':
        return np.array([
            [c, 0, s],
            [0, 1, 0],
            [-s, 0, c]
        ])
    if axis == 'x':
        return np.array([
            [1, 0, 0],
            [0, c, -s],
            [0, s, c]
        ])
    return np.array([
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 1]
    ])