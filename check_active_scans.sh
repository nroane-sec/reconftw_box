#!/usr/bin/env bash

reconftw_file_location="./reconftw.sh" #Point this to the actual reconftw script

scan="$reconftw_file_location $@"

echo "Your desired scan is: $scan"

function check_active_scans(){
	ps aux | grep -v grep | grep reconftw > /dev/null #redir output to hide it
	
	check="$?" #need to assign this variable right away so it captures the exit status of the ps above

	echo "$check"

	if [[ "$check" -eq "0" ]]; then
		echo "THERE IS ALREADY AND INSTANCE OF RECONFTW IN PROGRESS..."
		echo "Would you like to add your scan to the queue? Y/N"
		#sleep 5
		read queue_scan
		
		if [[ $queue_scan == "Y" ]]; then
			# TODO - need to check if that scan is already queued so people don't clog it up with duplicates

			
			echo "Adding your scan to the queue..."
			echo "$scan" >> queued_scans.rftw

		elif [[ $queue_scan == "N" ]]; then
			echo "Ok, we won't add you scan"
		fi
		# TODO Add the desired scan to a queue file?

	elif [[ "$check" -eq 1 ]]; then
		#statements
		echo "There are no active scans running, you may proceed... with caution"
	fi
}

check_active_scans


# TODO
# What do we do next?
# DONE -push the desired scan into a file to be called upon when the initial scan has finished?
# - Figure out how to pop the top value out of the queue file and then start that scan
