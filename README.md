## This repository contains the core code used to manage the rvs program

 > The "autonomy branch" is created as a standalone package.
 The original code was set up in a directory structure that I
 had no control over (containted lots of spaces and underscores).
 This branch will function on it's own, including a script to
 create a local diretory test set and fill it with some test rvs's.

An "rvs" is a word document. It is a summary of a research participant's visit. This summary must be completed and sent to the participant's primary care physicians. A research visit is overseen by an attending physician (aka attending), who must complete one for every participant they see. There are 12 attendings responsible for a number of rvs's each. Each attending has a folder containing their rvs's. The rvs amanager (me) will place a rough draft rvs (drafted by others) in the appropriate folder when a participant finishes a research visit. The attending will move an RVS out of their folder and into the "DONE" folder when finished. Each rvs is named "lname, fname_id_yyyy.mm.dd_RVS" (I also did not have control over the convention) and is either a .doc or.docx.

This standalone package can be downloaded to a local machine and used with full functionality to test the code. First make a directory for this, then run "RVS_test_setup.sh" to generate fake attendings and rvs's and create and empty csv called "RVS_report.csv". Next, run "RVS_reporter.sh" to fill the csv with data and generate a bar graph. Finally, edit your email in "RVS_emailer.sh" to receive all emails (meant to go to the fake attendings) and run it to see them.

----

Check out "rvs_lifecycle.txt" for a schematic of the directory structure and a more visual explanation of where they go, "test_email.txt" to see one of the emails "RVS_emailer.sh" should send, and "figure_1.png" to see what "RVS_vis.py" should produce.

Also, start to manually change around the info in the rvs filenames or move some around like the rvs manager or attending would to see how "RVS_emailer.sh" and "RVS_reporter.sh" give different output.

----

* RVS_test_setup.sh initializes a set of directories for 12 fake attendings. It also generates random fake rvs's in each directory. RVS_reporter_newfunction.sh and RVS_emailer_newfunction.sh need to be edited to match this 'autonomous' version of the directory structure (is much simpler than the real one!)


* RVS_reporter.sh generates a .csv summarizing the rvs's that each attending is responsible for. Then, the .csv is passed to RVS_vis to generate a stacked bar graph. This can be executed regularly (via crontab) without the visualization for regular logging of rvs's. This script must have the function executed for all 12 attendings if passing output to RVS_vis (or RVS_vis must be edited to fit the number of attendings). This script will have test attendings sensitive information (all fake). It is also a bash script.

* RVS_emailer.sh contains the function for a set of weekly rvs emails (to each attending). This has all sensitive information removed (attending names and email addresses). This script will have test attendings sensitive information (all fake). It is also a bash script.It is set up such that a week that is > 3 weeks old is "overdue". The weekly recurrance is done through crontab, which must be edited (see comments within code). It is a bash script and was written on a linux machine. Therefore coreutils must be brew installed for this to work on a mac (currently set up as such) where 'date' in linux becomes 'gdate' in unix. Note that the visualization is based off of a 6 month cutoff while the emailer is set up with a 3 week due-date.

* RVS_vis.py is the visualization script called in RVS_reporter_newfunction.sh. It requires pandas and the latest matplotlib. This can be run as a standalone if user does not want rvs's to be logged (to avoid mucking up the log with irregular, repeated responses). It is a python script. Recommend using anaconda2.

 > dependencies: bash, python, matplotlip, pandas, coreutils (if using mac)

-peter
