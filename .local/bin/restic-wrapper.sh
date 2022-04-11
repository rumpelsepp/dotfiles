#!/usr/bin/env bash

set -eu

usage() {
	echo "usage: $(basename "$0") [-H HOST] [-h]"
	echo ''
	echo '  -H    Host for which the command is for'
	echo '  -h    Show this page and exit'
}

main() {
	HOST="$(hostname)"

	while getopts "Hh" arg; do
		case "$arg" in
		H) HOST="$OPTARG" ;;
		h) usage && exit 0 ;;
		*) usage && exit 1 ;;
		esac
	done

	shift $((OPTIND - 1))

	case "$HOST" in
	kronos)
		export RESTIC_REPOSITORY="rclone:owncloud.fraunhofer.de:backups_private/nodes"
		export RESTIC_PASSWORD_COMMAND='pass show backups/alderaan-storagebox'
		;;

	cube)
		export RESTIC_PASSWORD="l2z510sxCaCCFpH2oOhoZqG1FZcYYZKjf141vOBRylAvLd9DgV"
		export RESTIC_REPOSITORY="rclone:owncloud_fraunhofer:backups_private/cube"
		;;
	esac

	exec restic "$@"
}

main "$@"
