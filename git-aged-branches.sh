#!/usr/bin/env bash

set -e

msg() {
  tput setab 2 # green bg
  tput setaf 7 # white text
  echo ">>> $1"
  tput sgr 0
  sleep 1
}

set_input_parameters() {
  while true ; do
    case "$1" in
      -h|--help)
        display_help "$@"
        exit 0
        ;;
        -d|directory)
            DIRECTORY=$2
            shift 2
        ;;
        -m|merged)
            MERGED=$2
            shift 2
        ;;
        *)
            break
        ;;
    esac
  done;
}

display_help() {
  echo "${BASH_SOURCE[0]} - shows git branches of defined repository with age of their last commit"
  echo " "
  echo "${BASH_SOURCE[0]} [options] [arguments]"
  echo " "
  echo "options:"
  echo "-h, --help                                            show brief help"
  echo "-d, --directory=DIR                                   specify path to directory with git repository"
  echo "-m, --merged=(merged|no-merged|merged <branch_name>)  show merged or not merged branches"
}

parse_input_parameters() {
  if [ ! -z "$DIRECTORY" ]; then
    msg "going to $DIRECTORY directory"
    cd $DIRECTORY
  fi

  if [ ! -z "$MERGED" ]; then
    msg "setting git branch parameter to --$MERGED"
  fi
}

fill_branches_with_last_commit_array() {
  # list all remote branches excluding master and develop
  remote_branches=$(git branch -rv --$MERGED | grep -v master | grep -v develop | awk '{print $1}')
  branches_with_last_commit_array=(); index=0

  for item in $remote_branches; do
    pretty_format="%C(bold cyan)%ar%C(reset) %C(green)%h%C(reset) %C(yellow)%s%C(reset)"
    last_commit=$(git log $item --pretty=format:"$pretty_format" -1)
    branches_with_last_commit_array[$index]="$item $last_commit"
    index=$(($index+1))
  done
}

display_branches_with_last_commit_array() {
  for item in "${branches_with_last_commit_array[@]}"; do
    echo -e "$item"
  done
}

main() {
  set_input_parameters "$@"
  parse_input_parameters "$@"
  msg "listing all remote branches with age of the last commit"
  fill_branches_with_last_commit_array "$@"
  display_branches_with_last_commit_array "$@"
}

main "$@"
