### jenkins.sh -- Jenkins interaction support

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

: ${jenkinsdir:=/var/lib/jenkins}

# jenkins_is_enabled
#  Predicate telling if the trac service is enabled

jenkins_is_enabled()
{
    config_service_is_enabled 'jenkins'
}


# jenkins_dump FILENAME
#  Dump Jenkins state

jenkins_dump()
{
    local environment
    install -d -o jenkins -g jenkins "${tmpdir}/jenkins"

    wlog 'Info' 'jenkins: Dump Jenkins state.'
    ( cd "${jenkinsdir}" && find '.' | cpio -dump "${tmpdir}/jenkins" )\
        2>&1
}


# jenkins_restore DUMPFILE
#  Restore Jenkins state

jenkins_restore()
{
    wlog 'Info' 'jenkins: Restore Jenkins state.'
    tar xJfC "$1" "${jenkinsdir}" --strip-components 2 ./jenkins/
}

### End of file `jenkins.sh'
