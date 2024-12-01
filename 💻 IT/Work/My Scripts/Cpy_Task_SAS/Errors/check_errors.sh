#!/bin/sh

color_red=$(tput setaf 1)
color_green=$(tput setaf 2)
color_yellow=$(tput setaf 3)
color_default=$(tput sgr0)

/sas/bin/sas94/SASFoundation/9.4/sas -nolog -stdio `dirname $0`/check_errors2.sas | \
    gawk                                \
    -v color_default=$color_default     \
    -v color_red=$color_red             \
    -v color_green=$color_green         \
    -v color_yellow=$color_yellow       \
    -v current_date=$(date '+%Y-%m-%d') \
    '
        NR > 1 {
            if ( NR < 5 ) color = color_default;
            else if ( $1 == current_date ) color = color_red;
            else color = color_yellow;
            printf("%s%s%s\n", color, $0, color_default);
        }
    '
