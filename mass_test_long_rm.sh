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

for i in {3..3}; do
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
	#run_test "$file1 $file2" "$_normal" "$output/long/neighbours_rm/0" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 3 -rm" #Standard
	#run_test "$file1 $file2" "$_normal" "$output/long/neighbours_rm/0.01" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.01 -s 3 -rm"
	#run_test "$file1 $file2" "$_normal" "$output/long/neighbours_rm/0.05" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 0.05 -s 3 -rm"
	#run_test "$file1 $file2" "$_normal" "$output/long/neighbours/2" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wp 0 -wneigh 2 -s 3 "

	#
	# "Best" of previous cube (not using std dev), using proximity in the energy function and less weight for normals
	#
	run_test "$file1 $file2" "$_normal" "$output/long/proximity_rm/1" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 1 -s 3 -rm"
	run_test "$file1 $file2" "$_normal" "$output/long/proximity_rm/0.05" "-i 50 --roomsize 4 -wlod0 4 -wlod1 3 -wlod2 2 -wlod3 1 -wv 1 -wn 1 -wneigh 0 -wp 0.05 -s 3 -rm"
done