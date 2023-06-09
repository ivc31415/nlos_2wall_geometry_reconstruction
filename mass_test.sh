function run_test () {
	# First parameter: Data npy files
	# Second parameter: Second normal
	# third parameter: Output **folder**
	# Fourth parameter: Program Arguments
	
	mkdir -p "$3"
	mkdir -p "$3/sequence"
	echo python main.py $1 \"-1 0 0\" "$2" $3/final.obj -sq \"$3/sequence\" -log \"$3/log.txt\" $4
	python main.py $1 "-1 0 0" "$2" $3/final.obj -sq "$3/sequence" -log "$3/log.txt" $4
}

declare -a FolderNames=("R_wall")
declare -a FileNames=("wall_R_")
declare -a Angles=("90.0" "90.0" "90.0")
declare -a Normals=("0 0 1" "0 0 1" "0 0 1")

for i in {0..0}; do
	_folder="${FolderNames[$i]}"
	_files="${FileNames[$i]}"
	_angle="${Angles[$i]}"
	_normal="${Normals[$i]}"

	file1=data/$_folder/"$_files"0.0_rec.npy
	file2=data/$_folder/"$_files""$_angle"_to_0.0_rec.npy
	output=output/batch/$_folder

	#
	# No proximity, no neighbours. Changing LOD weights. Cube
	#

	run_test "$file1 $file2" "$_normal" "$output/lodweights/1_1_1_1" "-i 10 --roomsize 4 -wlod0 1 -wlod1 1 -wlod2 1 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights/1_2_3_4" "-i 10 --roomsize 4 -wlod0 1 -wlod1 2 -wlod2 3 -wlod3 4 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights/4_3_2_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights/1_2.5_2_7" "-i 10 --roomsize 4 -wlod0 1 -wlod1 2.5 -wlod2 2 -wlod3 7 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights/1_0_0_1" "-i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights/1_0_0_10" "-i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 10 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights/10_0_0_1" "-i 10 --roomsize 4 -wlod0 10 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"

	#
	# Same as before, but using the standard deviation of the volumes
	#

	run_test "$file1 $file2" "$_normal" "$output/lodweights_fb/1_1_1_1" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 1 -wlod2 1 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_fb/1_2_3_4" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 2 -wlod2 3 -wlod3 4 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_fb/4_3_2_1" "-fb -i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_fb/1_2.5_2_7" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 2.5 -wlod2 2 -wlod3 7 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_fb/1_0_0_1" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_fb/1_0_0_10" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 10 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_fb/10_0_0_1" "-fb -i 10 --roomsize 4 -wlod0 10 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"

	#
	# "Best" of previous cube (not using std dev), using neighbours in the energy function
	#
	run_test "$file1 $file2" "$_normal" "$output/neighbours/0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/neighbours/0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.1 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/neighbours/0.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.25 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/neighbours/0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.5 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/neighbours/1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/neighbours/1.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1.25 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/neighbours/1.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1.5 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/neighbours/2" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 2 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/neighbours/5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 5 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/neighbours/10" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 10 -s 3"

	#
	# "Best" of previous cube (not using std dev), using proximity in the energy function and less weight for normals
	#
	run_test "$file1 $file2" "$_normal" "$output/proximity/0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/proximity/0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0.1 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/proximity/0.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0.25 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/proximity/0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0.5 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/proximity/1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/proximity/1.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1.25 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/proximity/1.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1.5 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/proximity/2" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 2 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/proximity/5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 5 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/proximity/10" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 10 -s 3"

	#
	# Vary normals-value weights
	#
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v1_n0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v1_n0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v1_n0.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v1_n0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.5 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v1_n0.75" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.75 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v0.75_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.75 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v0.5_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.5 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v0.25_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.25 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v0.1_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal/v0_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0 -wn 1 -wneigh 0 -wp 0 -s 3"

	#
	# Vary size of room (effectively changing the size of the sphere)
	#
	run_test "$file1 $file2" "$_normal" "$output/roomsize/2" "-i 10 --roomsize 2 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/2.5" "-i 10 --roomsize 2.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/3" "-i 10 --roomsize 3 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/3.5" "-i 10 --roomsize 3.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/4" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/4.5" "-i 10 --roomsize 4.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/5" "-i 10 --roomsize 5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/5.5" "-i 10 --roomsize 5.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/6" "-i 10 --roomsize 6 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/6.5" "-i 10 --roomsize 6.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/7" "-i 10 --roomsize 7 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/7.5" "-i 10 --roomsize 7.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/8" "-i 10 --roomsize 8 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/8.5" "-i 10 --roomsize 8.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/9" "-i 10 --roomsize 9 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/9.5" "-i 10 --roomsize 9.5 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
	run_test "$file1 $file2" "$_normal" "$output/roomsize/10" "-i 10 --roomsize 10 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0 -s 3"
done