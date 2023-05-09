# reconftw_box
Scripts for queueing up reconftw scans one after the other if there is already an instance of reconftw running.

This is meant for offloading reconftw scans on to an external machine to reduce local resource consumption and prevent clogging up the VPN connection.


# Required Configuration
1) You must edit your master reconftw.sh file to add the following line at the very bottom of the "end()" function:

. "$start_next_scan"

After adding the above line, reconftw will now be capable of kicking off the next scan waiting in the "queued_scans.rftw" file

2) Run reconftw with the files in this repo in the same directory as the master reconftw.sh script


# TODO
- Validate user input so we only accept "Y/N" variants
- Properly delete the top line of the "queued_scans.rftw" file when reconftw.sh is done scanning, possibly similar to step 1), add a call to remove the line when the scan is complete
-     - If this is the route we take, there must be a check in place to ensure that the top value from the queued_scans.rftw file is not removed         when it does not match the current scan name. The current scan should only remove matching values from the queued_scans.rftw list
