#!/bin/sh

### cid_restore -- Operate on Cid repositories

# El Cid (https://github.com/michipili/cid)
# This file is part of El Cid
#
# Copyright © 2018 Michael Grünewald
#
# This file must be used under the terms of the MIT license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution. The terms
# are also available at
# https://opensource.org/licenses/MIT

: ${package:=@PACKAGE@}
: ${packagedir:=/@PACKAGEDIR@}
: ${version:=@VERSION@}
: ${prefix:=@prefix@}
: ${libexecdir:=@libexecdir@}
: ${localstatedir:=@localstatedir@}
: ${subrdir:=@datadir@/subr}
: ${cachedir:=${localstatedir}/cache${packagedir}}
: ${config_dir:=/opt/cid/var/config}
: ${tracdir:=/var/trac}
: ${gitdir:=/var/git}

. "${subrdir}/stdlib.sh"
. "${subrdir}/config.sh"
. "${subrdir}/trac.sh"

# restore_git DUMPFILE
#  Dump git repositories

restore_git()
{
    wlog 'Info' '%s: Restore git repositories.' "$1"
    tar xJfC "$1" "${gitdir}" --strip-components 2 ./git/
}

# restore_main DUMP-NAME
#  Dump main

restore_main()
{
    local OPTIND OPTION OPTARG
    local dumpfile

    OPTIND=1

    while getopts 'n' OPTION; do
        case ${OPTION} in
            h)	restore_usage; exit 0;;
            *)	failwith -x 70 'cid_restore: %s: Unsupported option.' "${OPTION}";;
        esac
    done
    shift $(expr ${OPTIND} - 1)
    config_setup

    if [ $# -ne 1 ]; then
        failwith -x 64 "cid_restore: Can restore exactly one dump file."
    fi
    dumpfile="$1"
    shift
    wlog_prefix="restore: ${dumpfile##*/}"

    wlog 'Info' 'Start to restore.'
    trac_restore "${dumpfile}"
    restore_git "${dumpfile}"
    wlog 'Info' 'Restore complete.'
}

restore_main "$@"

### End of file `cid_restore.sh'
