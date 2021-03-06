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
 autoconf\
 bmake\
 bsdtar\
 curl

install -d -o cid -g cid -m 700 /usr/local/src
su -l cid -c '
 set -e
 cd /usr/local/src
 curl -L https://github.com/michipili/bsdowl/archive/master.zip | bsdtar xf -
 cd bsdowl-master
 autoconf
 ./configure --prefix=/usr/local --with-credentials=sudo
 bmake all
'

( cd /usr/local/src/bsdowl-master && bmake install )
