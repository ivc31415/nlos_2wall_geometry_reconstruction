import numpy as np

def generate_points(subdivisions = 1):
    s = subdivisions + 1
    p = np.zeros((3, 0))

    # Side Face
    n_face = (s - 1) * s
    f_side = np.zeros((3, n_face))
    c = 0
    for i in range(s - 1):
        for j in range(s):
            P = np.array([
                1,
                1 - 2 * (j / s),
                1 - 2 * ((i + 1) / s)
            ])
            P = P / np.linalg.norm(P)
            f_side[:, c] = P
            c += 1

    p = f_side
    p = np.concatenate((p, np.array([[0, -1, 0],[1, 0, 0],[0, 0, 1]]) @ f_side), axis=1)
    p = np.concatenate((p, np.array([[0, 1, 0],[-1, 0, 0],[0, 0, 1]]) @ f_side), axis=1)
    p = np.concatenate((p, np.array([[-1, 0, 0],[0, -1, 0],[0, 0, 1]]) @ f_side), axis=1)

    # Top/Bottom Face
    n_face = (s + 1)**2
    f_top = np.zeros((3, n_face))
    c = 0
    for i in range(s + 1):
        for j in range(s + 1):
            P = np.array([
                1 - 2 * (i / s),
                1 - 2 * (j / s),
                1
            ])
            P = P / np.linalg.norm(P)
            f_top[:, c] = P
            c += 1

    p = np.concatenate((p, f_top), axis=1)
    p = np.concatenate((p, np.array([[-1, 0, 0],[0, -1, 0],[0, 0, -1]]) @ f_top), axis=1)



    return p
