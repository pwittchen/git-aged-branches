#!/usr/bin/env bash

set -e

msg() {
  tput setaf 2 # green text
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

display_branches() {
  for branch in `git branch -rv --$MERGED | awk '{print $1}'`; do
    pretty_format="%C(green)%ci%C(reset) %C(bold cyan)%ar%C(reset) %C(yellow)%h%C(reset)"
    echo `git show --pretty=format:"$pretty_format" $branch | head -n 1` $branch;
  done | sort -r
}

main() {
  set_input_parameters "$@"
  parse_input_parameters "$@"
  msg "listing all remote branches with age of the last commit"
  display_branches
}

main "$@"
