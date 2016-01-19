## This repository contains the core code used to manage the rvs program.

 > The "autonomy branch" is created as a standalone package.
 The original code was set up in a directory structure that I
 had no control over (part of a shared server - containted lots of spaces and underscores...). This branch will simulate your very own local rvs program on a mac or linux machine.

An "rvs" is a summary of a research participant's visit. An rvs is completed every time someone participates in the research project. This summary must be completed and sent to the participant's primary care physicians in a timely fashion, so that it offers clinically relevent advise and documentation. A research visit is conducted by many people, but is always overseen by an attending physician (aka attending), who must approve and complete the rvs. There are 12 attendings in this case. The rvs project has it's own root directory in which each attending has a folder containing their rvs's. When a participant finishes their research visit, the rvs manager will place a rough draft rvs (drafted by another clinician that saw the participant) in the appropriate attending's folder (after proofreading and checking for innapropriate disclosure). The attending will make edits and approve the rvs, then move it into the "DONE" folder. From the "DONE" folder, the rvs manager will again check for any innaprioate disclosure and bring the rvs to a standard formatting before sending out and archiving. Each rvs is named "lname, fname_id_yyyy.mm.dd_RVS" and is either a .doc or .docx word document.

The rvs manager is responsible for making sure each rvs is written, completed, sent, and archived in a timely fashion. There is a tracking sheet (not included here) linked to the database of particpants who come in for research visits to ensure that each note is written, but once the file ends up in the rvs directory, it becomes necessary to track the attending's work programmatically. It is not bery efficient to do by hand...

This standalone package can simulate the rvs project flow. To create this simulation, first pull the repository to a new directory and run "RVS_test_setup.sh". Next, run "RVS_reporter.sh" to fill the csv with data and generate a bar graph. Finally, edit in your email to the 'self_email' variable in "RVS_emailer.sh" to receive all emails (meant to go to the fake attendings) and run it to send them.

----

Check out "rvs_lifecycle.txt" for a schematic of the directory structure and a more visual explanation of where rvs's go, "test_email.txt" to see one of the emails "RVS_emailer.sh" should send, and "figure_1.png" to see what "RVS_vis.py" should produce.

Also, start to manually change around the info in the rvs filenames or move some around/make new ones like the rvs manager or attending would to see how "RVS_emailer.sh" and "RVS_reporter.sh" give different output.

----

* RVS_test_setup.sh initializes the linked directory structure and generates random fake rvs's. It also creates an empty "RVS_report.csv".


* RVS_reporter.sh fills "RVS_report.csv" with data summarizing the rvs's that each attending is responsible for. Then, the .csv is passed to "RVS_vis.py" to generate a stacked bar graph. This can be executed regularly (via crontab) without the visualization for regular logging of rvs's. The rvs manager needs to keep a close eye on progress and report to the PI, so it helps to do this programmatically. This script must have the function executed for all 12 attendings if passing output to "RVS_vis.py" (or "RVS_vis.py" must be edited to fit the number of attendings). This script will have test attendings sensitive information (all fake). It is also a bash script. Therefore, coreutils must be brew installed for this to work on a mac (currently set up as such) where 'date' in linux becomes 'gdate' in unix.

* RVS_emailer.sh can be set up with crontab to send weekly rvs reminder emails to each attending. Attendings are often busy running other studies and appreciate regular reminding. The script is set up such that an rvs that is > 3 weeks old is "overdue" (note that this is different from the reporter - 6 months marks the cutoff for clinically relevent advice). It is a bash script and was written on a linux machine. Like above, any occurance of 'date' is 'gdate' for os x.

* RVS_vis.py is the visualization script called in RVS_reporter_newfunction.sh. It requires pandas and the latest matplotlib. This can be run as a standalone if user does not want rvs's to be logged (to avoid mucking up the log with irregular, repeated responses). It is a python script, written in python2. Recommend using anaconda2 (ships with all python packages needed and more) or at least pip as a package manager.

 > dependencies: mac os x or linux-based operating system, bash shell, python 2, matplotlib, pandas, coreutils (if using mac), recommend also using homebrew package manager if using mac.
