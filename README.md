This repo contains the core code for rvs functionality. There
are 12 attendings responsible for a number of rvs's each. Each
attending has a directory containing their rvs's. Each rvs is 
named "lname, fname_id_yyyy.mm.dd_RVS" and is either a .doc or
.docx.

	> RVS_emailer_newfunction.sh contains the function for the
	  weekly rvs emails without any of the sensitive
	  information. It is a bash script.

	> RVS_reporter_newfunction.sh is the same as above
	  but for irregular reporting purposes. This also can
	  be executed without the visualization for regular
	  logging of rvs's. This script also must have the
	  function executed for all 12 attendings. It is also a
	  bash script.

	> RVS_vis.py is the visualization script. It requires
	  pandas and the latest matplotlib. This can be run as 
	  a standalone if user does not want rvs's to be logged.
	  It is a python script.

-peter