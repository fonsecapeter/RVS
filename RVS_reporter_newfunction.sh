#!/bin/bash
# PPG RVS reporter by Peter Fonseca
# adapted from RVS_emailer by Peter Fonseca
# requires empty or existing RVS_report.csv and RVS_vis.py,
# which requires python, pandas, and latest matplotlib
# appends new set of 12 rows to RVS_report.csv
# header is: name,daterported,numrvs,numoverdue
# troubleshooting/development commands denoted by ##

reporter () {
  name_first = $1
  name_dir = $2

filecount="0"
parsecount="0"
rvscount="0"
rvsoverduecount="0"

DATE=$(date +%Y%m%d)
datedash=$(date +%Y-%m-%d)
##echo "today is [$DATE]"

# first get all files in one var
files="$(ls -1 /mnt/mac/Research/FTD\ PPG/PPG\ Research\ Visit\ Summaries/OUTSTANDING_RVS/$name_dir/*RVS*)"
# parse into each files
arr=$(echo "$files" | tr ";" "\n")
for x in $arr
do
  let filecount++
  ##echo "file $filecount"
  # parse each filename to extract pidn and date
  # because of dir/fname structure/convention,
  # 3rd of numericals is pidn, 4th is date
  arrloop=$(echo "> [$x]" | tr "_" "\n")
  for x in $arrloop
  do
    let parsecount++
     ##echo "parse $parsecount"
    if [ $parsecount -eq 3 ] && [ $x -eq $x ] 2>/dev/null; then
      # count outstanding rvs's
      let rvscount++
      ##echo "pidn_$rvscount > [$x]"
    fi
    if [ $parsecount -eq 4 ]; then
      ##echo "date_$rvscount > [$x]"
        rvsdate=$( echo "$x" | tr -d ".")
        ##echo "rvsdate $rvsdate"
      # calculate due date of 6 months after visit
      # for each rvs
      DUEDATE=$(date -d "$rvsdate 6 months" +%Y%m%d)
      ##echo "due: $DUEDATE"
      if [ "$DATE" -ge "$DUEDATE" ]; then
        # count overdue rvs's
        let rvsoverduecount++
        ##echo "> $name_first_[$rvscount] is overdue"
      fi
    fi
  done
  parsecount="0"
done

# append new line to RVS_report.csv with attending's notes
echo "$name_first,$datedash,$rvscount,$rvsoverduecount"  >> RVS_report.csv
echo "> $name_first's RVS's reported on [$datedash]"
}

# repeat below for all attendings
# name_first = first name
# name_dir = attendings directory

# reporter <name_first> <name_dir>

# visualize the RVS_report.csv
./RVS_vis.py