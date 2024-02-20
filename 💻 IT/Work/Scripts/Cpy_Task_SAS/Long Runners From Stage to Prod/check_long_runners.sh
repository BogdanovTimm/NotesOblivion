#! /bin/sh

color_red=$(tput setaf 1)
color_green=$(tput setaf 2)
color_yellow=$(tput setaf 3)
color_default=$(tput sgr0)

DONE_LOW=100

/sas/bin/sas94/SASFoundation/9.4/sas -nolog -stdio `dirname $0`/check_long_runners.sas | \
        gawk \
        -v color_default=$color_default \
        -v color_red=$color_red \
        -v color_green=$color_green  \
        -v color_yellow=$color_yellow \
        -v done_low=$DONE_LOW \
        '
            $1 != "STATUS" && NF==2 {
                if ( $1 == "CURRENT" || ( $1 == "_DONE_" && $2 > done_low ) ) color=color_green;
                else if ( $1 == "LONG") color=color_yellow;
                else color=color_red;
                printf("%s%s%s\n",color,$0,color_default);
            }
        '
