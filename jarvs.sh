#!/bin/bash
# syntax: jarvs <command>
# to do:
#  * build initial menu framework
#  * set arguments for running the big three
#  * set arguments for other useful commands
#  * maintain list of <command> s

tput setaf 2
	echo "Hello, ${USER}. What can I help you with?"
tput sgr0

# main menu----------------------------------------

while true; do
	menu="main"

	while [ menu="main" ]; do
		read cmd

		case "$cmd" in

		*"how are you"*)
			tput setaf 2
				echo "I can't complain"
			tput sgr0
			continue
		;;

		*"bye"*)
			tput setaf 2
				echo "Goodbye, let me know if you need anything else."
			tput sgr0
			exit
		;;

		*"help"*)
			tput setaf 2
				echo "I am your personal assistant, you can call me Jarvs."
				echo "Peter built me to help you manage the rvs program."
				echo "All you have to do is give me a command."
				echo "Ask me for a list to see what commands I am programmed"
				echo "to understand"
			tput sgr0 
			continue
		;;

		*"list"*)
			tput setaf 2
				echo "<bye> <help> <list> <eamil> <report>"
			tput sgr0
			continue
		;;

		*"email"*)
			tput setaf 2
				echo "I'm sorry I can't help you with that."
				echo "Peter is still working on the code."
			tput sgr0
			continue
		;;

		*"report"*)
			tput setaf 2
				echo "Of course, I am programmed to tell you how the attendings are doing."
			tput sgr0
			menu="report"
			break
		;;

		*"thank"*)
			tput setaf 2
				echo "No need to thank me, it's my job."
			tput sgr0
			continue
		;;

		*)
			tput setaf 2
				echo "I'm terribly sorry, I don't understand that."
				echo "Try typing 'help' or 'bye'"
			tput sgr0
			continue
		;;
		esac
	done

# reporting menu ----------------------------------------

	while [ menu="report" ]; do
		tput setaf 2
			echo "How can I help you with reporting?"
		tput sgr0
		read cmd

		case $cmd in

		*"done"*)
			tput setaf 2
				echo "Fantastic, what else can I do for you?"
				menu="main"
			tput sgr0
			continue 2
			;;

		*"bye"*)
			tput setaf 2
				echo "Goodbye, let me know if you need anything else."
			tput sgr0
			exit
		;;

		*"report"*)
			tput setaf 2
				echo "No problem, let me crunch the numbers."
				echo "I'll show you all the rvs's currently waiting"
				echo "for approval"
				./RVS_reporter.sh
			tput sgr0	
			continue
		;;

		*"vis"*)
			tput setaf 2
				echo "No problem, let me crunch the numbers."
				echo "I'll show you all the rvs's waiting for approval"
				echo "since the last time I reported."
				echo "I won't log the data on this one"
				./RVS_vis.py
			tput sgr0
			continue
		;;

		*help*)
			tput setaf 2
				echo "You last told me that wanted some help reporting."
				echo "If you need something else say done"
			tput sgr0
			continue
		;;

		*)
			tput setaf 2
				echo "I'm terribly sorry, I don't understand that."
				echo "Try typing 'help' or 'bye'"
			tput sgr0
			continue
		;;
		esac
	done

done