#!/bin/bash
# PPG RVS emailer by Peter Fonseca
# troubleshooting/development commands denoted by ##
# cron job should be  0 9 * * Wed /home/pfonseca/RVS_emailer_newfunction.sh
# crontab -e opens crontab for editting, choose nano
# crontab -l displays current crontab entries
# * * * * * command to be executed
# - - - - -
#  \ \ \ \ \
#   \ \ \ \ [----- day of week (0-7) (Sunday or Sun = 0)
#    \ \ \ [------ month (1-12)
#     \ \ [------- day of month (1-31)
#      \ [-------- hour (0-23)
#       [--------- minute (0-59)

# define function to be repeated for every attending
emailer () {
  name_first = $1
  name_last = $2
  name_dir = $3
  name_email = $4

filecount="0"                                                                # initialize variables
parsecount="0"
rvscount="0"
rvsoverduecount="0"
echo "Dr. $name_first $name_last," | cat > email.txt                         # initialize txt for email
echo "" | cat > premail.txt

DATE=$(date +%Y%m%d)
##echo "today is [$DATE]"

files="$(ls -1 ./$name_dir/*RVS*)"  # first get all full file names in one var
arr=$(echo "$files" | tr ";" "\n")                                           # parse into each short file name
for x in $arr
do
  let filecount++
  ##echo "file $filecount"
  arrloop=$(echo "> [$x]" | tr "_" "\n")                                      # parse each filename to extract pidn and date
  for x in $arrloop                                                           # because of dir/fname structure/convention,
  do                                                                          # 3rd of numericals is pidn, 4th is date
    let parsecount++                                                         
     ##echo "parse $parsecount"
    if [ $parsecount -eq 3 ] && [ $x -eq $x ] 2>/dev/null; then
      let rvscount++                                                          # count outstanding rvs's
      ##echo "pidn_$rvscount > [$x]"
      rvspidn=$x                                                              # get pidn
    fi
    if [ $parsecount -eq 4 ]; then
      ##echo "date_$rvscount > [$x]"
        rvsdate=$( echo "$x" | tr -d ".")                                     # get date for calculation
        rvsdatedash=$( echo "$x" | tr "." "-")                                # get date for email
        ##echo "rvsdate $rvsdate"
      DUEDATE=$(date -d "$rvsdate 3 weeks" +%Y%m%d)                           # calculate due date of 3 weeks after visit for each RVS
      DUEDATEDASH=$(date -d "$DUEDATE" +%Y-%m-%d)                             # calculate due date formatted for email
      if [ "$DATE" -ge "$DUEDATE" ]; then
        let rvsoverduecount++                                                 # count overdue rvs's
        echo "  $rvspidn from $rvsdatedash is OVERDUE" | cat >> premail.txt 
      else
        echo "  $rvspidn from $rvsdatedash is due $DUEDATEDASH" | cat >> premail.txt
      fi
    fi
  done
  parsecount="0"
done

echo "You have [$rvscount] RVS's outstanding. [$rvsoverduecount] of these are overdue, please approve." | cat >> email.txt    # compose email
cat premail.txt >> email.txt
echo "" | cat >> email.txt                                                                                        
echo "Files are in H:\Research\FTD PPG\PPG Research Visit Summaries\OUTSTANDING_RVS\$name_dir" | cat >> email.txt
echo "" | cat >> email.txt
echo "Do not reply to this email, please contact Peter.Fonseca@ucsf.edu if you have any questions." | cat >> email.txt

if [ "$rvscount" -gt "0" ]; then
  mail -s "Overdue PPG RVS's" -c "Peter.Fonseca@ucsf.edu" "$name_email" < email.txt # send attd email if they have any outstanding RVS's
  echo "> email sent to [$name_email]"                                                                          
fi
}

# unhash below and repeat for all attendings
# name_first = first name
# name_last = last name
# name_dir = directory name in hdrive
# name_email = email address

# emailer <name_first> <name_last> <name_dir> <name_email>

rm email.txt                                                                 # remove email txt files
rm premail.txt