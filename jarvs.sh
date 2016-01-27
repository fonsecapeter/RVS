#!/bin/bash
# syntax: jarvs <command>
# to do:
#  * build initial menu framework
#  * set arguments for running the big three
#  * set arguments for other useful commands
#  * maintain list of <command> s

set_color () {
	# introduce jarvs if first time using
	if [ ! -f ./clr.txt ]; then
		echo "Hello, ${USER}"
		echo "My name is Jarvs, and I am your personal assistant."
		echo "Peter built me to help manage the rvs program."
		echo "I hope you find that I make life easier."
		echo "Before we get started, what is your favorite color?"
	else
		echo "What is your favorite color?"
	fi
	echo "choices are: red, green, orange,"
	echo "blue, purple, light-blue, and white"
	read fav_clr

	case "$fav_clr" in
		red)
			echo "1" > ./clr.txt
		;;

		green)
			echo "2" > ./clr.txt
		;;

		orange)
			echo "3" > ./clr.txt
		;;

		blue)
			echo "4" > ./clr.txt
		;;

		purple)
			echo "5" > ./clr.txt
		;;

		light-blue)
			echo "6" > ./clr.txt
		;;

		white)
			echo "7" > ./clr.txt
		;;

		*)
			echo "I'm sorry, I don't know that one."
			echo "Try typing your color in lower-case."
		;;
	esac

	clr=`cat ./clr.txt`
	tput setaf $clr
		echo "Much better, Thanks!"
		echo "If you ever change your mind,"
		echo "just ask me to change your preferences."
	tput sgr0
}

# if first time using jarvs, set favorite color
if [ ! -f ./clr.txt ]; then
	set_color
fi

clr=`cat ./clr.txt`

puts () {
	output=$1
	tput setaf $clr
		echo "$1"
	tput sgr0
}

puts "Hello, ${USER}. What can I help you with?"

menu="main"

# put all menu's in infinite loop ----------------------
while true; do

	# main menu ----------------------------------------
	while [ $menu == "main" ]; do
		read cmd

		case "$cmd" in

			*"list"*)
				puts "<bye> <help> <list> <preferences> <eamil> <report>"
				puts "<date> <agenda> <weather>"
				continue
			;;

			*"help"*)
				puts "I am your personal assistant, you can call me Jarvs."
				puts "Peter built me to help you manage the rvs program."
				puts "All you have to do is give me a command."
				puts "Ask me for a list to see what commands I am programmed"
				puts "to understand"
				puts "You can always tell me to take a break by saying bye."
				continue
			;;

			*)
				prev_menu="$menu"
				menu="utils"
				break
			;;
		esac
	done

	# utilities menu ----------------------------------------	
	while [ $menu == "utils" ]; do
		case $cmd in

			*"bye"*)
				puts "Goodbye, let me know if you need anything else."
				exit
			;;

			*"done"*|*"nothing"*|*"main"*)
				puts "Fantastic, what else can I do for you?"
				menu="main"
				break
			;;

			*"list"*)
				puts "<bye> <help> <list> <preferences> <eamil> <report>"
				puts "<date> <agenda> <weather>"
				continue
			;;

			# linux weather-util & weather-util-data, mac need ansiweather?
			*"weather"*|*"forecast"*)
				echo ""
				tput setaf $clr
				weather 94158
				tput sgr0
				echo ""
			;;


			*"date"*|*"cal"*)
				puts "Always good to stay oriented."
				echo ""
				tput setaf $clr
				cal
				tput sgr0
				echo ""
			;;

			# need to download icalbuddy and test on mac
			*"today"*)
				puts "Here is your agenda for the day:"
				echo ""
				tput setaf $clr
				icalbuddy -f -sc eventsToday
				tput sgr0
				echo ""
			;;

			*"preference"*)
				puts "I do appreciate feedback."
				menu="preferences"
				break
			;;

			*"report"*)
				puts "Of course, I am programmed to tell you how the attendings are doing."
				menu="report"
				break
			;;

			*"email"*)
				puts "Of course, I am programmed to help you send emails."
				menu="email"
				break
			;;				

			*"thank"*)
				puts "No need to thank me, it's my job."
			;;

			*"how are you"*)
				puts "I can't complain"
			;;

			*)
				puts "I'm terribly sorry, I didn't understand that."
				puts "Try typing help, list, done, or bye."
				puts "Make sure you are typing in lower-case."
			;;
		esac

		menu="$prev_menu"
		break
	done

	# preferences menu ----------------------------------------
	while [ $menu == "preferences" ]; do
		puts "What can I do differently?"
		read cmd

		case $cmd in

			*"color"*)
				set_color
				continue
			;;

			*"list"*)
				puts "<color>"
				puts "<bye> <help> <list> <eamil> <report>"
				puts "<date> <agenda> <weather>"
				continue
			;;

			*help*)
				puts "You last told me that wanted to edit your preferences."
				puts "If you need something else, just let me know."
				continue
			;;

			*)
				prev_menu="$menu"
				menu="utils"
				break
			;;
		esac
	done

	# reporting menu ----------------------------------------
	while [ $menu == "report" ]; do

		puts "How can I help you with reporting?"
		read cmd

		case $cmd in

			*"report"*)
				puts "No problem, let me crunch the numbers."
				puts "I'll show you all the rvs's currently waiting"
				puts "for approval"
				tput setaf $clr
				./RVS_reporter.sh
				tput sgr0
				continue
			;;

			*"vis"*)
				puts "No problem, let me crunch the numbers."
				puts "I'll show you all the rvs's waiting for approval"
				puts "since the last time I reported."
				puts "I won't log the data on this one"
				tput setaf $clr
				./RVS_vis.py
				tput sgr0
				continue
			;;

			*"list"*)
				puts "<report> <vis>"
				puts "<bye> <help> <list> <preferences> <eamil>"
				puts "<date> <agenda> <weather>"
				continue
			;;

			*help*)
				puts "You last told me that wanted some help reporting."
				puts "If you need something else, just let me know."
				continue
			;;

			*)
				prev_menu="$menu"
				menu="utils"
				break
			;;
		esac
	done

	# emailing menu ----------------------------------------
	while [ $menu == "email" ]; do
		puts "How can I help you with emails?"
		read cmd

		case $cmd in

			*"email"*)
				puts "No problem, let me write these up."
				tput setaf $clr
				./RVS_emailer.sh
				tput sgr0
				continue
			;;

			*"list"*)
				puts "<email>"
				puts "<bye> <help> <list> <preferences> <report>"
				puts "<date> <agenda> <weather>"
				continue
			;;

			*help*)
				puts "You last told me that wanted some help sending emails."
				puts "If you need something else, just let me know."
				continue
			;;

			*)
				prev_menu="$menu"
				menu="utils"
				break
			;;
		esac
	done

done
