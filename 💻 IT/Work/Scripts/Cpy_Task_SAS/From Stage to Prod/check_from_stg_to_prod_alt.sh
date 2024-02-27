#! /bin/sh

color_red=$(tput setaf 1)
color_green=$(tput setaf 2)
color_yellow=$(tput setaf 3)
color_default=$(tput sgr0)

/sas/bin/sas94/SASFoundation/9.4/sas -nolog -stdio `dirname $0`/check_from_stg_to_prod_alt.sas | \
        gawk                            \
        -v color_default=$color_default \
        -v color_red=$color_red         \
        -v color_green=$color_green     \
        -v color_yellow=$color_yellow   \
        '
            NR > 1 {
                if ( NR < 3 ) color=color_default;
                else if ($1 == "RUNNING_OR_PENDING_0-24_HOURS" ||
                         $1 == "CANCELLED_EARLIER_ON_THIS_WEEK")
                    color = color_green
                else if ($1 == "RUNNING_OR_PENDING_24+_HOURS" ||
                         $1 == "CANCELLED_YESTERDAY")
                    color = color_yellow
                else if ($1 == "RUNNING_OR_PENDING_72+_HOURS" ||
                         $1 == "CANCELLED_TODAY")
                    color = color_red
                printf("%s%s%s\n", color, $0, color_default);
            }
        '
