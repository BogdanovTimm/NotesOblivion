#! /bin/sh

color_red=$(tput setaf 1)
color_green=$(tput setaf 2)
color_yellow=$(tput setaf 3)
color_default=$(tput sgr0)

/sas/bin/sas94/SASFoundation/9.4/sas -nolog -stdio `dirname $0`/check_from_sas_to_stg.sas | \
        gawk \
        -v color_default=$color_default \
        -v color_red=$color_red \
        -v color_green=$color_green  \
        -v color_yellow=$color_yellow \
        -v done_low=$DONE_LOW \
        '
            NR > 1 {
                if ( NR < 5 ) color=color_default;
                else color=color_red;
                printf("%s%s\n", color, $0);
            }
        '
