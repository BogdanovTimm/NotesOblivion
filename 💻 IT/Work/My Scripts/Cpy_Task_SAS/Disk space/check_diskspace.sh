#! /bin/sh

color_red=$(tput setaf 1)
color_green=$(tput setaf 2)
color_yellow=$(tput setaf 3)
color_default=$(tput sgr0)

/sas/bin/sas94/SASFoundation/9.4/sas -nolog -stdio `dirname $0`/check_diskcpace.sas | \
        gawk                            \
        -v color_default=$color_default \
        -v color_red=$color_red         \
        -v color_green=$color_green     \
        -v color_yellow=$color_yellow   \
        '
            NR > 1 {
                if ( NR < 3 ) color=color_default;
                else if ( $2 >= 75 ) color = color_red
                else if ( $2 >= 50 ) color = color_yellow
                else if ( $2 <  50 ) color = color_green
                printf("%s%s%s\n", color, $0, color_default);
            }
        '
