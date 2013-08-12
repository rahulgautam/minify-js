#! /bin/bash

# Author: Rahul Gautam
# Description: Minify all js files of a project at once


closure_compiler_location="./closure-compiler/compiler.jar"

exit_script(){
    echo "";
    exit 1;
}

check_dir(){
    # Check if <source_folder_for_js_files>, <destination_folder_for_js_file>
    # and closure_compiler_location present at location or not.
    if [ ! -f $closure_compiler_location ];
        then
        echo "  [Error] Closure compiler does not exits, Please recheck >" $closure_compiler_location;
        exit_script
    fi

    if [ ! -d $1 ];
        then
        echo "  [Error] Source directory path does not exits, Please recheck >" $1;
        exit_script
    fi

    if [ ! -d $2 ];
        then
        echo "  [Error] Destination directory path does not exits, Please recheck >" $2;
        exit_script
    fi

}

create_dir(){
    # Will create the same sub-floder structure in <destination_folder_for_js_file>
    # As present in <source_folder_for_js_files>
    dirs_list=`find $1 -type d -not -iwholename '*.svn*' -not -iwholename '*.git*' -exec echo "{}" \;`
    flag=1
    for i in $dirs_list
    do
        if [ $flag -eq 1 ];  # just to ignore base folder of source directory
        then
            flag=2
            continue
        fi
        mkdir $2/${i#*$1/} 2> /dev/null
    done
}

convert()
{
    # Will minify all js files
    # closure_compiler_location should be correct
    echo
    echo "            --------------------            "
    js_files=`find $1 -type f -name "*.js" -not -iwholename '*.svn*' -exec echo "{}" \;`

    for i in $js_files
    do
        java -jar $closure_compiler_location --js $i --js_output_file $2/${i#*$1/};
    done
    echo "            --------------------            "
    echo

}


# Main script starts from here

DIRNAME=`dirname $0`
case "$1" in
    help)
        echo " HELP :"
        echo " ======="
        echo " # bash minify.sh <source_folder_for_js_files> <destination_folder_for_js_file>"
        echo
        echo "  Note: Folder/Directory path should be absolute path "
        echo
        echo "  It will recursivly traverse all subfolders and js files in <source_folder_for_js_files>
          And will create the same sub-floder structure in <destination_folder_for_js_file> if not present
          while minifing js files."
        exit_script
        ;;
esac

if [ $# -ne 2 ]
then
    echo "   Invalid Arguments "
    echo "   try : # sh minify.sh help"
    exit_script
fi

echo
echo " Note: Directory path should be absolute path "
echo
echo "   Source directory path contains full JS files            : $1"
echo "   Destination directory path where to write min JS files  : $2"
echo
echo -n "  Do you Really Want to Continue with this? [yes or no] : "
read yno
case $yno in
        [yY] | [yY][Ee][Ss] )
            echo "                                                 Agreed : [OK] "

            check_dir $1 $2  # Is directory present at given path

            create_dir $1 $2

            convert $1 $2

            echo " ======================================================== [DONE] "
            ;;
        [nN] | [nN][Oo] )
            echo "                    Not agree, Can't proceed further : [EXIT]";
            exit_script
            ;;
        *)
            echo "     [Error] Invalid arguments \n";
            exit_script
            ;;
esac
echo



