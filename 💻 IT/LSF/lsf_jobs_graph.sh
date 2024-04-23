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

listOfErrors="
1 3
2 4
1 5
2 8
"
listOfErrors=$(echo "$listOfErrors" | grep -v ^$ | sort --numeric)
numberOfErrors=$(echo "$listOfErrors" | grep -v ^$ -c)

listOfPending="
3 5
5 7
3 7
4 8
4 6
"
listOfPending=$(echo "$listOfPending" | grep -v ^$ | sort --numeric)
numberOfPending=$(echo "$listOfPending" | grep -v ^$ -c)

echo "$listOfErrors"
echo "Number of Exit Jobs: $numberOfErrors"
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