### support.sh -- Install support programs in a docker image

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

su -l cid -c '
 set -e
 cd /opt/cid/var/src/support
 autoconf
 ./configure --prefix=/opt/cid
 bmake -I/usr/local/share/bsdowl all
'

( cd /opt/cid/var/src/support && bmake -I/usr/local/share/bsdowl install )

### End of file `support.sh'
