import numpy as np
import torch
import math

import rot

def generate_points(subdivisions = 1, make_sphere = True):
    s = subdivisions + 1
    p = np.zeros((3, 2))

    p[:, 0] = np.array([0, 0, 1]).T
    p[:, 1] = -p[:, 0]

    cor1 = (rot.rot_matrix(math.pi / 3, 'y') @ p[:, 0])[np.newaxis].T
    cor2 = rot.rot_matrix(math.pi * 0.4, 'z') @ cor1
    cor3 = rot.rot_matrix(math.pi * 0.2, 'z') @ rot.rot_matrix(math.pi / 3, 'y') @ cor1

    # Side Faces
    deltaV = (cor3 - cor1) / s
    deltaH = (cor2 - cor1) / s
    for j2 in range(s + 1):
        for f in range(5):
            for f2 in range(2):
                j = j2 - f2
                for i in range((1 - f2) * (s - j - 1) + f2 * j + 1):
                    P = cor1 + i * deltaH + ((1 - f2) * j + f2 * (s - j - 1)) * deltaV
                    if f2 == 1:
                        P = rot.rot_matrix(math.pi * 0.2, 'z') @ np.array([[1, 0, 0],[0,1,0],[0,0,-1]]) @ P
                    P = rot.rot_matrix(math.pi * 0.4 * f, 'z') @ P
                    p = np.concatenate((p, P), axis=1)

    # Top Faces
    deltaV = (p[:, 0] - cor1.T).T / s #Vertical
    for f2 in range(2):
        for j in range(1, s):
            for f in range(5):
                for i in range(s - j):
                    P = cor1 + i * deltaH + j * deltaV
                    if f2 == 1:
                        P = rot.rot_matrix(math.pi * 0.2, 'z') @ np.array([[1, 0, 0],[0,1,0],[0,0,-1]]) @ P
                    P = rot.rot_matrix(math.pi * 0.4 * f, 'z') @ P
                    p = np.concatenate((p, P), axis=1)

    if make_sphere:
        for i in range(np.size(p, 1)):
            P = p[:, i]
            p[:, i] = P / np.linalg.norm(P)

    return p

def list_of_faces(subdivisions):
    faces = []

    s = subdivisions + 1

    # Tri data
    # Side faces
    s5 = 5 * s
    for j in range(s):
        for i in range(s5):
            x1 = s5 * j + i
            x2 = x1 + 1
            x3 = x1 + s5
            x4 = x3 + 1
            if x2 >= s5 * (j + 1):
                x2 -= s5
                x4 -= s5
            faces += [[x1 + 3, x3 + 3, x2 + 3]]
            faces += [[x2 + 3, x3 + 3, x4 + 3]]

    # Top Faces
    for f2 in range(2):
        c = 0
        for j in range(1, s - 1):
            for f1 in range(5):
                for i in range(s - j):
                    x1 = 3 + 5 * s**2 + s5 + c
                    x2 = x1 + 1
                    x3 = x1 + 5 * (s - j) - f1
                    x4 = x3 + 1

                    if i == s - j - 1 and f1 == 4:
                        x2 -= 5 * (s - j)
                        x3 = x1 + 1
                    if i == s - j - 2 and f1 == 4:
                        x4 = x1 + 2

                    x1 += int(5 * ((s * (s - 1)) / 2)) * f2
                    x2 += int(5 * ((s * (s - 1)) / 2)) * f2
                    x3 += int(5 * ((s * (s - 1)) / 2)) * f2
                    x4 += int(5 * ((s * (s - 1)) / 2)) * f2

                    if f2 == 0:
                        faces += [[x1, x2, x3]]
                        if i != s - j - 1:
                            faces += [[x2, x4, x3]]
                    else:
                        faces += [[x1, x3, x2]]
                        if i != s - j - 1:
                            faces += [[x2, x3, x4]]

                    c += 1

    # Top-Side joining
    for f2 in range(2):
        for f1 in range(5):
            for i in range(s):
                x1 = 3 + f1 * s + i
                x2 = x1 + 1
                x3 = 3 + 5 * s**2 + s5 + i + f1 * (s - 1)
                x4 = x3 + 1

                if x1 >= s5 + 2:
                    x2 -= s5
                    x3 -= 5 * (s - 1)

                if i == s - 2 and f1 == 4:
                    x4 = 3 + 5 * s**2 + s5

                if f2 == 1:
                    x1 += f2 * s5 * s
                    x2 += f2 * s5 * s
                    x3 += int(5 * ((s * (s - 1)) / 2))
                    x4 += int(5 * ((s * (s - 1)) / 2))

                if f2 == 0:
                    faces += [[x1, x2, x3]]
                    if i < s - 1:
                        faces += [[x3, x2, x4]]
                else:
                    faces += [[x1, x3, x2]]
                    if i < s - 1:
                        faces += [[x2, x3, x4]]

    # Two corners joining
    for f2 in range(2):
        for f1 in range(5):
            x1 = (3 + 5 * s**2 + s5) + (5 * ((s - 1) * s)/2 - 5) + f1
            x2 = x1 + 1
            if f1 == 4: x2 -= 5
            x1 += 5 * ((s * (s - 1)) / 2) * f2
            x2 += 5 * ((s * (s - 1)) / 2) * f2

            if f2 == 0:
                faces += [[int(x1), int(x2), 1 + f2]]
            else:
                faces += [[int(x2), int(x1), 1 + f2]]

    return faces

def neighbours_matrix(p, subdivisions):
    faces = list_of_faces(subdivisions)

    n = p.shape[1]

    neighbours = torch.zeros((n, n), dtype=torch.bool)

    for i in range(len(faces)):
        face = faces[i]
        neighbours[face[0] - 1][face[1] - 1] = True
        neighbours[face[0] - 1][face[2] - 1] = True
        neighbours[face[1] - 1][face[0] - 1] = True
        neighbours[face[1] - 1][face[2] - 1] = True
        neighbours[face[2] - 1][face[0] - 1] = True
        neighbours[face[2] - 1][face[1] - 1] = True

    return neighbours

def save_as_obj(p, subdivisions, file='output_fancy.obj', n=None):
    s = subdivisions + 1
    nCheck = n is not None

    # File and Header
    f = open(file, "w")
    f.write("# ---------------------------------------------\n");
    f.write("# Reconstructed model from NLOS 2-wall data\n")
    #f.write("# Generated with code from Isaac Velasco Calvo\n");
    f.write("# ---------------------------------------------\n");
    f.write("\n")

    # Vertex data
    for i in range(np.size(p, 1)):
        f.write(f"v {p[0, i]} {p[1, i]} {p[2, i]}\n")

    f.write("\n")

    # Normals data
    if nCheck:
        for i in range(np.size(n, 1)):
            f.write(f"vn {n[0, i]} {n[1, i]} {n[2, i]}\n")

    faces = list_of_faces(subdivisions)

    # Faces
    for i in range(len(faces)):
        _wv(f, faces[i][0], faces[i][1], faces[i][2], nCheck)

    f.close()

# Write vector to .obj, with specification for adding normals or not
def _wv(f, x1, x2, x3, n=False):
    if n:
        f.write(f"f {x1}//{x1} {x2}//{x2} {x3}//{x3}\n")
    else:
        f.write(f"f {x1} {x2} {x3}\n")