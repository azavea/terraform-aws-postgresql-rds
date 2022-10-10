#!/bin/bash

USAGE="Lint the project's code with optional format
Options:
format - run formatting too."

check_for_help_flag() {
	if [[ "$*" == *"help"* ]]; then
		echo -e "Usage: $(basename "$0") $USAGE_ARG_LIST \n"
		echo -e "$USAGE"
		exit
	fi
}

check_for_help_flag "$@"

if [[ "${1:-}" == "format" ]]; then
	echo "Formatting"
	APPLY_FIXES=all
else
	echo "Just linting"
	APPLY_FIXES=none
fi

docker run --rm -e APPLY_FIXES=$APPLY_FIXES -v "$PWD":/tmp/lint oxsecurity/megalinter-terraform:v6
