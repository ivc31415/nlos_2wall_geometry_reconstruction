# TODO
- [X] Parametrize *everything*
  - [X] Arguments
- [ ] Intialization
  - [ ] That's it, we raymarching in this house (From barycenter, raymarch outwards until you hit maximum of volume)
  - [X] Move sphere to center of mass
  - [X] Make sphere size logical (Messing too much with room size)
    - [X] Std. Dev. of every voxel (taking into account weight) to center of mass
- [ ] Energy function
  - [X] Negative energy on proximity to other vertices?
  - [X] Revisit normals function
    - [X] Keep original normal?
    - [ ] Calculate normal depending on nearby vertices?
  - [X] Out-of-volume vertices?
  - [X] Standard deviation of edges sizes. Keep small?
  - [X] Make cosine of normal negative on perpendicular
  - [ ] Compare bounding box of reconstruction with volume (thresehold) (?)
  - [ ] Do the neighbour things with triangles instead of edges?
  - [ ] Proximity: Weight based on inverse volume?
- [X] Visualize OBJs through time
  - [X] Fix OpenGL3 problems in laptop (Run on python, not conda)
- [X] Pass every parameter inside dictionary instead of each one separately
- [X] Switch repository to ivc account
- [X] Make 256 resolution depend on input
- [ ] ITERATIONS

## Discoveries
- V0 (Far plane) is overpowered by V1 (Close plane)