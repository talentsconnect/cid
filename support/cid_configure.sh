#!/bin/sh

### cid_configure -- Configure an El Cid Project

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
: ${cachedir:=${localstatedir}/cache${packagedir}}

: ${configdir:=/opt/cid/var/config}
: ${gitdir:=/var/git}
: ${gnupgdir:=/home/cid/.gnupg}
: ${sshdir:=/home/cid/.ssh}
: ${tracdir:=/var/trac}
: ${wwwdir:=/var/www}


# failwith [-x STATUS] PRINTF-LIKE-ARGV
#  Fail with the given diagnostic message
#
# The -x flag can be used to convey a custom exit status, instead of
# the value 1.  A newline is automatically added to the output.

failwith()
{
    local OPTIND OPTION OPTARG status

    status=1
    OPTIND=1

    while getopts 'x:' OPTION; do
        case ${OPTION} in
            x)	status="${OPTARG}";;
            *)	1>&2 printf 'failwith: %s: Unsupported option.\n' "${OPTION}";;
        esac
    done

    shift $(expr ${OPTIND} - 1)
    {
        printf 'Failure: '
        printf "$@"
        printf '\n'
    } 1>&2
    exit "${status}"
}

configure_config()
{
    git config --file "${configdir}/cid.conf" "$@"
}

configure_environment_db()
{
    git config --file "${configdir}/cid.conf" --list\
        | awk -F '[.]' '{s[$1]}END{for(t in s){print t}}'
}


configure_assert()
{
    if ! [ -f "${configdir}/cid.conf" ]; then
        failwith -x 70 '%s: File not found.' "${configdir}/cid.conf"
    fi
}


# configure_git
#  Configure the git subsytem
#
# This makes sure the root of the filesystem holding the git
# repositories is owned by the git user.

configure_git()
{
    chown 'git:git' "${gitdir}"
}


# configure_gpg
#  Import GPG keys in in cid keyring
#
# This imports the GPG keys in "${configdir}/gpg" in cid user keyring.
# If that directory does not exist, this phase is skipped.

configure_gpg()
{
    chown 'cid:cid' "${gnupgdir}"
    chmod '700' "${gnupgdir}"

    if [ -d "${configdir}/gpg" ]; then
        su cid -c "
          find ${configdir}/gpg -type f -exec gpg --no-use-agent --import '{}' ';'
        "
    fi
}


# configure_ssh
#  This imports a SSHconfiguration for the cid user.
#
# This imports the SSH configuration in "${configdir}/ssh" in cid user
# account.  If that directory does not exist, this phase is skipped.

configure_ssh()
{
    chown 'cid:cid' "${sshdir}"
    chmod '700' "${sshdir}"

    if [ -d "${configdir}/ssh" ]; then
        (
            set -e
            cd "${configdir}/ssh"
            find . | cpio -dump --owner 'cid:cid' "${sshdir}"
        )

        find "${sshdir}" -type f -exec chmod go= '{}' ';'
    fi
}


# configure_trac
#  This creates trac environments specified by the main confguration file.

configure_trac()
{
    local environment location

    chown www-data:www-data "${tracdir}"
    install -d -o www-data -g www-data -m 750\
            "${tracdir}/sites"\
            "${tracdir}/www"\
            "${tracdir}/git"

    configure_environment_db | while read environment; do
        location=$(configure_config "${environment}.location")
        : ${location:=/trac/${environment}}
        configure_trac_environment "${environment}" "${location}"
    done

}


# configure_trac_environment NAME WWW-LOCATION
#  Prepare a trac environment

configure_trac_environment()
{
    install -d -o www-data -g www-data -m 750\
            "${tracdir}/$1"\
            "${wwwdir}/$1"

    install -d -o git -g git -m 750\
            "${gitdir}/$1"

    su -l www-data -s '/bin/sh' <<TRAC-ADMIN
trac-admin "${tracdir}/$1" initenv "$1" sqlite:db/trac.db
trac-admin "${tracdir}/$1" deploy "${wwwdir}/$1"
TRAC-ADMIN

    install -o www-data -g www-data -m 640 /dev/null "${tracdir}/sites/$1.htpasswd"
    install -o www-data -g www-data -m 640 /dev/null "${tracdir}/sites/$1.conf"
    cat >> "${tracdir}/sites/$1.conf" <<SITE-CONF
Alias $2/chrome ${wwwdir}/$1/htdocs

<Directory "${wwwdir}/$1/htdocs">
  <IfModule mod_authz_core.c>
    Require all granted
  </IfModule>
</Directory>

<Location "$2/login">
  AuthType Basic
  AuthName "Trac $1"
  AuthUserFile ${tracdir}/sites/$1.htpasswd
  Require valid-user
</Location>

WSGIScriptAlias $2 ${wwwdir}/$1/cgi-bin/trac.wsgi
SITE-CONF
}


configure_batch()
{
    configure_git
    configure_trac
}

#
# Main
#

configure_assert
configure_batch

### End of file `cid_configure.sh'
