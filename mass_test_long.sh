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

declare -a FolderNames=("cube" "R" "wall_cozy_chair" "wall_bunny")
declare -a FileNames=("" "R_" "wall_cozy_chair_" "wall_bunny_" )
declare -a Angles=("90.0" "90.0" "90.0" "90.0")
declare -a Normals=("0 0 1" "0 0 1" "0 0 1" "0 0 1")

for i in {2..3}; do
	_folder="${FolderNames[$i]}"
	_files="${FileNames[$i]}"
	_angle="${Angles[$i]}"
	_normal="${Normals[$i]}"

	file1=data/$_folder/"$_files"0.0_rec.npy
	file2=data/$_folder/"$_files""$_angle"_to_0.0_rec.npy
	output=output/batch/$_folder

	#
	# "Best" of previous cube (not using std dev), using neighbours in the energy function
	#
	run_test "$file1 $file2" "$_normal" "$output/long/neighbours/0" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 "
	run_test "$file1 $file2" "$_normal" "$output/long/neighbours/0.25" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.25 -s 3 "
	run_test "$file1 $file2" "$_normal" "$output/long/neighbours/1" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 1 -s 3 " #1 hour on the bunny!
	#run_test "$file1 $file2" "$_normal" "$output/long/neighbours/2" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 2 -s 3 " #Takes 2 hour for the chair!

	#
	# "Best" of previous cube (not using std dev), using proximity in the energy function and less weight for normals
	#
	run_test "$file1 $file2" "$_normal" "$output/long/proximity/1" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 1 -s 3 "
	run_test "$file1 $file2" "$_normal" "$output/long/proximity/5" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.25 -wneigh 0 -wp 5 -s 3 "

	#
	# Vary normals-value weights
	#
	run_test "$file1 $file2" "$_normal" "$output/long/value_vs_normal/v1_n0" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0 -wneigh 0 -wp 0 -s 3 "
	run_test "$file1 $file2" "$_normal" "$output/long/value_vs_normal/v1_n0.5" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 0.5 -wneigh 0 -wp 0 -s 3 "
	run_test "$file1 $file2" "$_normal" "$output/long/value_vs_normal/v0.5_n1" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0.5 -wn 1 -wneigh 0 -wp 0 -s 3 "
	run_test "$file1 $file2" "$_normal" "$output/long/value_vs_normal/v0_n1" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 0 -wn 1 -wneigh 0 -wp 0 -s 3 "
done