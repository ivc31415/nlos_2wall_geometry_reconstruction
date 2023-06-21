#python main.py "data/R_wall/wall_R_0.0_rec.npy" "data/R_wall/wall_R_90.0_to_0.0_rec.npy" "output/output1.obj" -i 10

# This one returns a cube, but one of its faces is looking away from the relay walls! Did I put a normal wrong? Also, normals are not optimised.
#python main.py "data/cube/0.0_rec.npy" "data/cube/90.0_to_0.0_rec.npy" "-1 0 0" "0 0 1" "output/output1.obj" -i 10

# Cube at x1.7
#python main.py "data/cube/0.0_rec.npy" "data/cube/90.0_to_0.0_rec.npy" "-1 0 0" "0 0 1" "output/output_1.7_barycenter_multiplier.obj" -i 20 --roomsize 6 -wlod0 1 -wlod1 2.5 -wlod2 0 -wlod3 7 -wn 2 -wp 0

# Slightly better from x1
#python main.py "data/cube/0.0_rec.npy" "data/cube/90.0_to_0.0_rec.npy" "-1 0 0" "0 0 1" "output/TEMP.obj" -i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -we 15 -s 2 -rm

#python main.py "data/R_wall/wall_R_0.0_rec.npy" "data/R_wall/wall_R_90.0_to_0.0_rec.npy" "-1 0 0" "0 0 1" "output/R_wall.obj" -i 10 --roomsize 6 -wlod0 1 -wlod1 2.5 -wlod2 2 -wlod3 7 -wn 2 -s 2 -wp 0
#python main.py "data/wall_cozy_chair/wall_cozy_chair_0.0_rec.npy" "data/wall_cozy_chair/wall_cozy_chair_90.0_to_0.0_rec.npy" "-1 0 0" "0 0 1" "output/TEMP.obj" -i 20 --roomsize 2 -wlod0 1 -wlod1 2.5 -wlod2 2 -wlod3 7 -wn 0 -s 2 -wp 0
#python main.py "data/bunny/bunny_0.0_rec.npy" "data/bunny/bunny_90.0_to_0.0_rec.npy" "-1 0 0" "0 0 1" "output/bunny.obj" -i 20 --roomsize 2 -wlod0 1 -wlod1 2.5 -wlod2 2 -wlod3 7 -wn 1 -wp 1 -s 4 -sq "output_seq"

#Cube (Deformed)
#python main.py "data/cube/0.0_rec.npy" "data/cube/90.0_to_0.0_rec.npy" "-1 0 0" "0 0 1" "output/TEMP.obj" -i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -we 15 -s 2 -rm

#Chair (?)
python main.py "data/wall_cozy_chair/wall_cozy_chair_0.0_rec.npy" "data/wall_cozy_chair/wall_cozy_chair_90.0_to_0.0_rec.npy" "-1 0 0" "0 0 1" "output/manual/chair/model.obj" -i 125 --roomsize 4 -wlod0 8 -wlod1 4 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -we 100 -s 4 -rm -sq "output/manual/chair/seq" -log "output/manual/chair/log.txt"