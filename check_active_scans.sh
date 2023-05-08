#!/usr/bin/env bash



function check_active_scans(){
	ps aux | grep -v grep | grep reconftw
	
	check="$?" #need to assign this variable right away so it captures the exit status of the ps above


	echo "$check"

	if [[ "$check" -eq "0" ]]; then
		echo "THERE IS ALREADY AND INSTANCE OF RECONFTW IN PROGRESS..."
		sleep 10
	elif [[ "$check" -eq 1 ]]; then
		#statements
		echo "There are no active scans running, you may proceed... with caution"
	fi
}

check_active_scans


#TODO
#What do we do next?
#schedule cron job?
#push the desired scan into a file to be called upon when the initial scan has finished?
#	and then is kicks off the next scan in the file until there are none left?