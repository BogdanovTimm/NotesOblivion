#!/usr/bin/env bash
################################################################################
# usage: ./archive.config.sh <queue>
# скрипт сжимает файлы по маске в config.pm.<queue>
################################################################################










[[ -n "$queue" ]] || queue="$1" # If [queue] don't already have value, then assign first argument to it
[[ -n "$PREFIX" ]] || PREFIX='/sas/scripts/' # If [queue] don't already have value, then assign '/sas/scripts/' to it
source "$PREFIX/scr/comm" || { echo "bad commands list" >&2 ; exit 1 ; } # Run this file or exit with error 
source "$PREFIX/scr/funs/common.sh" || { echo "bad common functions source" >&2 ; exit 1 ; }
source "$PREFIX/scr/funs/archive.sh" || { echo "bad archive functions source" >&2 ; exit 1 ; } 
exmask='lost\+found|readme|\.Z$|\.gz$|\.bz2$|\.tgz$|\.xz$|nohup\.out$|\.ftp$|\/SAS_work|\/cpy_|\.sas$|\.sh$|\.ksh$|\.lck$|\.lock$'
compress_level=1
compress_proc_threads=1
ionice_class=3
fdepth='-mindepth 1 -maxdepth 1'
[[ -n "$queue" ]] || { echo "bad queue:$queue" >&2 ; exit 1 ; }
source_cfg # ???
source_qcfg # ???
scr_dir="$(dirname -- "`readlink -f -- $0`")" # Gets directory name of this script ('--' means that next lines need to be treated like filenames)
scr_name="$(basename -- "`readlink -f -- $0`")" #Gets filename from  ...
tmp_dir="`mktemp -d "${PREFIX}/tmp/${scr_name}.${queue}.XXXXXX"`"
cd -P "$tmp_dir" || { echo "fail to create tmp_dir:$tmp_dir" >&2 ; exit 1 ; } # '-P' means that program should not follow symbolic links
dl="$tmp_dir/directory.log"
fl="$tmp_dir/finden.log"
ln -sT $varg -- "$scr_dir/config.get_dirs.pl" "get_dirs.pl" # ? Creates soft-link, but...
ln -sT $varg -- "$scr_dir/config.get_files.pl" "get_files.pl"
cfgpm="$scr_dir/config.pm.$queue"
ln -sT $varg -- "$cfgpm" "config.pm"









# find files
./get_dirs.pl || { echo "./get_dir.pl failed" >&2 ; exit 1 ; } # Runs Perl script
exec 4< <(cat "$dl") # Saves output from 'cat "$dl"' into File Descriptor 4
    while read -u 4 dir # Reads File Descriptor 4 line by line and saves each line in [dir]
    do
        [[ -d "`readlink -f -- "$dir"`" ]] || { echo "bad dir:$dir in $cfgpm" >&2 ; continue ; } # Checks if directory can be cyeated
        find -H $dir $fdepth -ignore_readdir_race -type f 2>&9 | grep -Evi "$exmask" >>"$fl" # Saves names of all files that don't match [exmask] to [[tmp_dir]/finden.log]
    done
exec 4<&- # Closes File Descriptor
# '-s' means 'files exists and has size > 0'
[[ -s "$fl" ]] && { \
./get_files.pl || { echo "./get_files.pl failed" >&2 ; exit 1 ; } \
; }










# compress files
for outlog in yyyymmdd.out.log yyyymm.out.log nodate.out.log
do
    if [[ -s "$outlog" ]];then
        exec 4< <(cat "$outlog")
        while read -u 4 file
        do
            if [[ "$compress_proc_threads" -gt 1 ]];then
                compress_file "$file" &
            fi
        done
        exec 4<&-
    fi
done
[[ "$DEBUG" == true ]] || { rm -rf -- "$tmp_dir" ; exit 0 ; }



for autooutlog in autoyyyymmdd.out.log autoyyyymm.out.log
do
    if [[ -s "$autooutlog" ]];then
        echo "found `wc -l $autooutlog` files, can be added to $cfgpm"
        cat "$autooutlog" >&9
    fi
done
