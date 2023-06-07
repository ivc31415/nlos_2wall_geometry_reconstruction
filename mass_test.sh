function run_test () {
	# First parameter: Data npy files
	# Second parameter: Second normal
	# third parameter: Output **folder**
	# Fourth parameter: Program Arguments
	
	mkdir -p "$3"
	mkdir -p "$3/sequence"
	python main.py $1 "-1 0 0" "$2" $3/final.obj -sq "$3/sequence" $4
}

run_test "data/cube/0.0_rec.npy data/cube/90.0_to_0.0_rec.npy" "0 0 1" "output/batch/1" "-i 10 --roomsize 4 -wlod0 1 -wlod1 2.5 -wlod2 4.5 -wlod3 7 -wv 1 -wn 1 -wp 0 -wneigh 0 -s 2"