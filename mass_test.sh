function run_test () {
	# First parameter: Data npy files
	# Second parameter: Second normal
	# third parameter: Output **folder**
	# Fourth parameter: Program Arguments
	
	mkdir -p "$3"
	mkdir -p "$3/sequence"
	python main.py $1 "-1 0 0" "$2" $3/final.obj -sq "$3/sequence" -log "$3/log.txt" $4
}


# ---------------------------------------------
# Tests
# ---------------------------------------------

#
# No proximity, no neighbours. Changing LOD weights. Cube
#

run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_1_1_1" "-i 10 --roomsize 4 -wlod0 1 -wlod1 1 -wlod2 1 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_2_3_4" "-i 10 --roomsize 4 -wlod0 1 -wlod1 2 -wlod2 3 -wlod3 4 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/4_3_2_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_2.5_2_7" "-i 10 --roomsize 4 -wlod0 1 -wlod1 2.5 -wlod2 2 -wlod3 7 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_0_0_1" "-i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_0_0_10" "-i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 10 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/10_0_0_1" "-i 10 --roomsize 4 -wlod0 10 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"