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

env DEBIAN_FRONTEND=noninteractive apt-get install -y\
 openssh-server\
 subversion\
 git

install -d /run/sshd

sed -i -E -e '
/PubkeyAuthentication (yes|no)/{
 i\
PubkeyAuthentication yes
 d
}

/PasswordAuthentication (yes|no)/{
 i\
PasswordAuthentication no
 d
}
' /etc/ssh/sshd_config


chsh -s /usr/bin/git-shell\
 git

install -d -o git -g git -m 750 /var/git
install -d -o git -g git -m 700 /var/git/.ssh
install -o git -g git -m 600 /dev/null /var/git/.ssh/authorized_keys
