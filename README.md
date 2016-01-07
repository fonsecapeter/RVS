This repo contains the core code for rvs functionality.

The "autonomy branch" is created to edit the code so that it
works as a standalone package. The original code was set up
in a directory structure that I had no control over
(containted lots of spaces and underscores). This branch will
function on it's own, including a script to create a local
diretory test set and fill it with some test rvs's.

An rvs is a word document. It is a summary of a research
participant's visit. The attending physician must complete
one for each participant they see. There are 12 attendings responsible for a number of rvs's each. Each attending has a directory containing their rvs's. Each rvs is named "lname, fname_id_yyyy.mm.dd_RVS" (also did not have control over the
convention) and is either a .doc or.docx.


	> RVS_reporter_newfunction.sh generates a .csv summarizing
	  the rvs's that each attending is responsible for. Then
	  the .csv is passed to RVS_vis to generate a stacked bar
	  graph. This can be executed regularly (via crontab)
	  without the visualization for regular logging of rvs's.
	  This script must have the function executed for all 12
	  attendings if passing output to RVS_vis (or RVS_vis must
	  be edited to fit the number of attendings). This script will have test attendings sensitive information (all 
	  fake). It is also a bash script.

	> RVS_emailer_newfunction.sh contains the function for a
	  set of weekly rvs emails (to each attending). This has
	  all sensitive information removed (attending names and
	  email addresses). This script will have test attendings sensitive information (all fake). It is also a bash
	  script.It is set up such that a week that is > 3 weeks
	  old is "overdue". The weekly recurance is done through
	  crontab, which must be editted (see comments within
	  code). It is a bash script.

	> RVS_vis.py is the visualization script called in
	  RVS_reporter_newfunction.sh. It requires pandas and the latest matplotlib. This can be run as a standalone if user does not want rvs's to be logged (to avoid mucking
	  up the log with irregular, repeated responses).
	  It is a python script.

-peter