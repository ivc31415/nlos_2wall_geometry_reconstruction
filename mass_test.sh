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

#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_1_1_1" "-i 10 --roomsize 4 -wlod0 1 -wlod1 1 -wlod2 1 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_2_3_4" "-i 10 --roomsize 4 -wlod0 1 -wlod1 2 -wlod2 3 -wlod3 4 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/4_3_2_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_2.5_2_7" "-i 10 --roomsize 4 -wlod0 1 -wlod1 2.5 -wlod2 2 -wlod3 7 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_0_0_1" "-i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/1_0_0_10" "-i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 10 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_cube/10_0_0_1" "-i 10 --roomsize 4 -wlod0 10 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"

#
# Same as before, but using the standard deviation of the volumes
#

#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_fb_cube/1_1_1_1" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 1 -wlod2 1 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_fb_cube/1_2_3_4" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 2 -wlod2 3 -wlod3 4 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_fb_cube/4_3_2_1" "-fb -i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_fb_cube/1_2.5_2_7" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 2.5 -wlod2 2 -wlod3 7 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_fb_cube/1_0_0_1" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_fb_cube/1_0_0_10" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 10 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/lodweights_fb_cube/10_0_0_1" "-fb -i 10 --roomsize 4 -wlod0 10 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"

#
# "Best" of previous cube (not using std dev), using neighbours in the energy function
#
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.1 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/0.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.25 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.5 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/1.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1.25 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/1.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1.5 -s 3"
##run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/2" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 2 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 5 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/neighbours_cube/10" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 10 -s 3"

#
# "Best" of previous cube (not using std dev), using proximity in the energy function and less weight for normals
#
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0.1 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/0.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0.25 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0.5 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/1.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1.25 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/1.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1.5 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/2" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 2 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 5 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/proximity_cube/10" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 10 -s 3"

#
# Vary normals-value weights
#
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v1_n0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v1_n0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.1 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v1_n0.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v1_n0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.5 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v1_n0.75" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.75 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v0.75_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.75 -wn 1 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v0.5_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.5 -wn 1 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v0.25_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.25 -wn 1 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v0.1_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.1 -wn 1 -wneigh 0 -wp 0 -s 3"
#run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/value_vs_normal_cube/v0_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0 -wn 1 -wneigh 0 -wp 0 -s 3"

#
# Vary size of room (effectively changing the size of the sphere)
#
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/2" "-i 10 --roomsize 2 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/2.5" "-i 10 --roomsize 2.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/3" "-i 10 --roomsize 3 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/3.5" "-i 10 --roomsize 3.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/4" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/4.5" "-i 10 --roomsize 4.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/5" "-i 10 --roomsize 5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/5.5" "-i 10 --roomsize 5.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/6" "-i 10 --roomsize 6 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/6.5" "-i 10 --roomsize 6.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/7" "-i 10 --roomsize 7 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/7.5" "-i 10 --roomsize 7.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/8" "-i 10 --roomsize 8 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/8.5" "-i 10 --roomsize 8.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/9" "-i 10 --roomsize 9 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/9.5" "-i 10 --roomsize 9.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/roomsize_cube/10" "-i 10 --roomsize 10 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"