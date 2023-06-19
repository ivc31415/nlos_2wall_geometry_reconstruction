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

declare -a FolderNames=("wall_bunny" "R" "cube" "wall_cozy_chair")
declare -a FileNames=("wall_bunny_" "R_" "" "wall_cozy_chair_")
declare -a Angles=("90.0" "90.0" "90.0" "90.0")
declare -a Normals=("0 0 1" "0 0 1" "0 0 1" "0 0 1")

for i in {0..3}; do
	_folder="${FolderNames[$i]}"
	_files="${FileNames[$i]}"
	_angle="${Angles[$i]}"
	_normal="${Normals[$i]}"

	file1=data/$_folder/"$_files"0.0_rec.npy
	file2=data/$_folder/"$_files""$_angle"_to_0.0_rec.npy
	output=output/batch/$_folder

	#
	# Same as before, but using the standard deviation of the volumes
	#

	run_test "$file1 $file2" "$_normal" "$output/lodweights_rm/1_1_1_1" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 1 -wlod2 1 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_rm/1_2_3_4" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 2 -wlod2 3 -wlod3 4 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_rm/4_3_2_1" "-fb -i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_rm/1_2.5_2_7" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 2.5 -wlod2 2 -wlod3 7 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_rm/1_0_0_1" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_rm/1_0_0_10" "-fb -i 10 --roomsize 4 -wlod0 1 -wlod1 0 -wlod2 0 -wlod3 10 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/lodweights_rm/10_0_0_1" "-fb -i 10 --roomsize 4 -wlod0 10 -wlod1 0 -wlod2 0 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 -rm"

	#
	# "Best" of previous cube (not using std dev), using neighbours in the energy function
	#
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.1 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/0.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.25 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.5 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/1.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1.25 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/1.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1.5 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/2" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 2 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 5 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/neighbours_rm/10" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 10 -s 3 -rm"

	#
	# "Best" of previous cube (not using std dev), using proximity in the energy function and less weight for normals
	#
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0.1 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/0.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0.25 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0.5 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/1.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1.25 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/1.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1.5 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/2" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 2 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 5 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/proximity_rm/10" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 10 -s 3 -rm"

	#
	# Vary normals-value weights
	#
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v1_n0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v1_n0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.1 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v1_n0.25" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v1_n0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.5 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v1_n0.75" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.75 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v0.75_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.75 -wn 1 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v0.5_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.5 -wn 1 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v0.25_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.25 -wn 1 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v0.1_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.1 -wn 1 -wneigh 0 -wp 0 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/value_vs_normal_rm/v0_n1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0 -wn 1 -wneigh 0 -wp 0 -s 3 -rm"
	
	#
	# Change power of each volume
	#
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0.1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0.1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0.2" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0.2 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0.3" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0.3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0.4" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0.4 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0.5" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0.5 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0.6" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0.6 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0.7" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0.7 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0.8" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0.8 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_0.9" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 0.9 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/1_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 1 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0.9_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0.9 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0.8_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0.8 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0.7_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0.7 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0.6_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0.6 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0.5_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0.5 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0.4_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0.4 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0.3_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0.3 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0.2_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0.2 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0.1_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0.1 -wv1 1 -rm"
	run_test "$file1 $file2" "$_normal" "$output/volume_balance/0_1" "-i 10 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 -wv0 0 -wv1 1 -rm"
done