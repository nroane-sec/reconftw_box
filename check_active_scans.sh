#!/usr/bin/env bash

reconftw_file_location="./reconftw.sh" #Point this to the actual reconftw script

scan="$reconftw_file_location $@"

echo "Your desired scan is: $scan"

function check_active_scans(){
	ps aux | grep -v grep | grep reconftw > /dev/null #redir output to hide it
	
	check="$?" # need to assign this variable right away so it captures the exit status of the ps above

	#echo "$check"

	if [[ "$check" -eq "0" ]]; then
		echo "THERE IS ALREADY AND INSTANCE OF RECONFTW IN PROGRESS...\n"
		echo "Would you like to add your scan to the queue? Y/N"
		#sleep 5
		read queue_scan
		
		if [[ $queue_scan == "Y" ]]; then
			# TODO - need to check if that scan is already queued so people don't clog it up with duplicates

			grep -n "$scan" queued_scans.rftw > /dev/null		# This checks the queued_scans.rftw file to see if the desired scan is already queued up
			
			if [[ $? -eq "0" ]]; then
				echo "This scan is already queued, sorry"
			elif [[ $? -eq "1" ]]; then
				echo "Adding your scan to the queue..."
				echo "$scan" >> queued_scans.rftw
			fi

		elif [[ $queue_scan == "N" ]]; then
			echo "Ok, we won't add your scan"
		fi


	elif [[ "$check" -eq 1 ]]; then

		echo "There are no active scans running, you may proceed... with caution"
		$scan 	# This launches the desired scan
	fi
}

check_active_scans


# TODO - Once a reconftw scan is completed, we should start the next one in the queue and remove it from the queue