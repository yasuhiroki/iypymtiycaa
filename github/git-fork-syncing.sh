#!/bin/bash -c

#------------------------------------------------------------------
# Title
#
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#------------------------------------------------------------------

####================------------------------==================#####
# Usage message {{{
####================------------------------==================#####
CMDNAME=`basename $0`
Usage(){
    echo "Usage: $CMDNAME [-uh] <origin repository url>"
    echo " <option>"
    echo "    -h                   : Show this help. "
    echo "    -u <remote name>     : Origin repository name [default: upstream]"
    echo " <args>"
    echo "    origin repository url: Original repository URL (ex. https://github.com/jenkins-ci/jenkins)."
    echo ""
}

# }}}
####================------------------------==================#####
# Functions {{{
####================------------------------==================#####
Echo(){
    echo "[$CMDNAME] $1"
}

Echo_Line(){
    if [ "$1" = 1 ];then
        mark_line="################################################################################"
    elif [ "$1" = 2 ];then
        mark_line="================================================================================"
    elif [ "$1" = 3 ];then
        mark_line="--------------------------------------------------------------------------------"
    else
        mark_line="********************************************************************************"
    fi  

    echo "$mark_line"
}

Fail(){
    Echo "[ERROR] $1"
    echo ""
    exit 1
}

# }}}
####================------------------------==================#####
# Resolve option. {{{
####================------------------------==================#####
while getopts u:h OPT
do
    case $OPT in
        "u")
            remote_name=$OPTARG
            ;;
        "h")
            Usage
            exit 1
            ;;
        "*")
            Usage
            exit 1
    esac
done
shift `expr $OPTIND - 1`

# }}}
####================------------------------==================#####
# Check argument
####================------------------------==================#####
EXPECTED_ARGS_NUM=1
if [ $# -ne $EXPECTED_ARGS_NUM ]; then
    Usage
    Fail "arguments incorrect"
fi

####================------------------------==================#####
# Environment Varrables
####================------------------------==================#####
remote_name=${remote_name:-upstream}
original_url=${1}

####================------------------------==================#####
# Body
####================------------------------==================#####
Echo_Line 1
Echo "Add original repository to sync my repository."
Echo_Line 1

git remote -v | grep ${remote_name} && echo "Already exists ${remote_name}"
git remote add ${remote_name} ${original_url}
git fetch upstream

current_branch=`git branch | awk '{print $2}'`
git merge ${remote_name}/${current_branch}

exit 0
