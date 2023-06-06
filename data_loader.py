import numpy as np

def load(file_name):
    D = np.load(file_name)
    return np.absolute(D)
