#!/bin/bash
# this script will create a local test
# directory set with one folder for each
# attending, containing rvs's of varying age
# this is meant to demonstrate an autonomous 
# test
# written by Peter Fonseca

# make an array of the 12 fake doctors directory names
attds[0] = "Vandalay,Art"
attds[1] = "Hibbert,Julius"
attds[2] = "Riviera,Nick"
attds[3] = "Vance,Bob"
attds[4] = "Fonseca,Peter"
attds[5] = "Kramer,Cosmo"
attds[6] = "Seinfeld,Jerry"
attds[7] = "Costanza,George"
attds[8] = "Benes,Elaine"
attds[9] = "Luthor,Lex"
attds[10] = "Kent,Clark"
attds[11] = "Lemon,Elizabeth"

# loop through attendings
for i in ${#attds[@]}
do 
	# create dir for each attd
	echo $i | mkdir

	# generate random number of test rvs's
	# and create them with some random info
	r = $(( $RANDOM % 12 ))
	while [ $counter -lt r ]
		year = (( date + "%Y"))
		month = (( $RANDOM % (%m -1) ))
		day = (( $RADNOM % 28 ))
		id = (( $RANDOM % 30000 ))

		echo "lname fname_id_$year.$month.$day_RVS.doc" | touch

		let counter++
	done

done