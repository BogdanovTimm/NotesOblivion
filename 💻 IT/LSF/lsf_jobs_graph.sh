#!/bin/bash

set -o pipefail #? echo $? after commandThatDidError | commandThatWasSuccess returns error code, instead of a success one

# parentJobId, givenIterator, givenOutput
checkPending() {
    echo "    Recursive Function Start"
    echo "    Given Output: $3"
    parentJobId="$1"
    echo "    Id to find: $parentJobId"
    givenIterator="$2"
    echo "    Given Iterator: $givenIterator"
    #local givenOutput="$3"
    for (( pendingIterator="$givenIterator"; pendingIterator <= "$numberOfPending"; pendingIterator++ )) ; do
        potentialFind=$(echo "$listOfPending" |   \
                gawk                              \
                -v currentLine="$pendingIterator" \
                -v parentJobId="$1"     \
                'NR == currentLine { 
                    if ($1 == parentJobId)
                        print $2
                }')
        echo "    Current Potential Find: $potentialFind"
        if [[ "$potentialFind" != "" ]] ; then
            echo "        Find new one!"
            echo "         Current new Oputput: $3 $potentialFind"
            nextIterator=$(( "$pendingIterator" + 1 ))
            nextParentJobId="$potentialFind"
            checkPending "$nextParentJobId" 1   "$3 $nextParentJobId"
            checkPending "$1"               "$nextIterator" "$3"
        fi
    done
        contains=$(cat ./lsf_jobs.txt | grep "$3")
        if [[ "$3 $nextParentJobId" == "" ]] ; then
            echo "--------Output: [$3]"
            if [[ "$contains" == "" ]] ; then
                echo "$3" >> ./lsf_jobs.txt
            fi
        else
            echo "--------Output: [$3 $nextParentJobId]"
            if [[ "$contains" == "" ]] ; then
                echo "$3 $nextParentJobId" >> ./lsf_jobs.txt
            fi
        fi
}

echo "" > ./lsf_jobs.txt

never_started_bjobs=$(bjobs -wp -u all | grep -B 1 never | grep sasetl)
number_of_never_started_bjobs=$(echo "$never_started_bjobs" | gawk 'END {print NR}')
echo "$never_started_bjobs"
echo "Number of never starting jobs: $number_of_never_started_bjobs"

# Find all EXIT jobs

#listOfErrors="
#1 3
#2 4
#1 5
#2 8
#"

for (( iterator=0; iterator <= $number_of_never_started_bjobs; iterator++ ))
do
    current_job_id=$(echo "$never_started_bjobs" | gawk -v iterator=$iterator 'NR == iterator {print $1}')
    echo "                    Current Iterator = "$iterator" Current Job Id = $current_job_id"
    #parent_info=$(bjdepinfo -l "$job_id" | gawk -v job_id="$job_id" '{if ($3 == "PEND" || $3 == "EXIT") print $0 }')
    current_exit=$(bjdepinfo -l "$current_job_id" | gawk -v job_id="$current_job_id" '{if ($3 == "EXIT") print $2, $1}')
    listOfErrors="$listOfErrors"\n"$current_exit"
    echo "$current_exit"
    echo ""
done
listOfErrors=$(echo "$listOfErrors" | grep -v ^$ | sort --numeric)
numberOfErrors=$(echo "$listOfErrors" | grep -v ^$ -c)
echo "$listOfErrors"
echo "Number of Exit Jobs: $numberOfErrors"

# Find all PENDING jobs

#listOfPending="
#3 5
#5 7
#3 7
#4 8
#4 6
#"

for (( iterator=1; iterator <= $number_of_never_started_bjobs; iterator++ ))
do
    current_job_id=$(echo "$never_started_bjobs" | gawk -v iterator=$iterator 'NR == iterator {print $1}')
    echo "                    Current Iterator = "$iterator" Current Job Id = $current_job_id"
    #parent_info=$(bjdepinfo -l "$job_id" | gawk -v job_id="$job_id" '{if ($3 == "PEND" || $3 == "EXIT") print $0 }')
    current_pending=$(bjdepinfo -l "$current_job_id" | gawk -v job_id="$current_job_id" '{if ($3 == "PEND") print $2, $1}')
    listOfPending="$listOfPending"\n"$current_pending"
    echo "$parent_info"
    echo ""
done


listOfPending=$(echo "$listOfPending" | grep -v ^$ | sort --numeric)
numberOfPending=$(echo "$listOfPending" | grep -v ^$ -c)
echo "$listOfPending"
echo "Number of Pending Jobs: $numberOfPending"

for (( exitIterator=1; exitIterator <= "$numberOfErrors"; exitIterator++ )) ; do
    echo "Exit iterator: $exitIterator"
    output=$(echo "$listOfErrors" |         \
            gawk                            \
            -v current_line="$exitIterator" \
            'NR == current_line {
                print $0
            }')
    pendingId=$(echo "$listOfErrors" |      \
            gawk                            \
            -v current_line="$exitIterator" \
            'NR == current_line {
                print $2
            }')
    echo "Current Pending ID to find dependencies: $pendingId"
    checkPending "$pendingId" 1 "$output"
done

cat ./lsf_jobs.txt