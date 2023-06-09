# TODO
- [X] Parametrize *everything*
  - [X] Arguments
- [ ] Intialization
  - [X] Move sphere to center of mass
  - [ ] Make sphere size logical (Messing too much with room size)
    - [X] Std. Dev. of every voxel (taking into account weight) to center of mass
- [ ] Energy function
  - [X] Negative energy on proximity to other vertices?
  - [X] Revisit normals function
    - [X] Keep original normal?
    - [ ] Calculate normal depending on nearby vertices?
  - [X] Out-of-volume vertices?
  - [X] Standard deviation of edges sizes. Keep small?
- [X] Visualize OBJs through time
  - [X] Fix OpenGL3 problems in laptop (Run on python, not conda)
- [ ] Pass every parameter inside dictionary instead of each one separately
- [ ] Switch repository to ivc account
- [X] Make 256 resolution depend on input

## Discoveries
- V0 (Far plane) is overpowered by V1 (Close plane)