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
 apache2\
 pwgen\
 git-core\
 libapache2-mod-wsgi\
 trac\
 trac-accountmanager\
 trac-authopenid\
 trac-bitten\
 trac-customfieldadmin\
 trac-xmlrpc\
 trac-wysiwyg\
 trac-mastertickets\
 trac-tags\
 trac-diavisview\
 trac-graphviz\
 python-flup\
 python-pip\
 python-psycopg2

a2enmod wsgi

install -d -o www-data -g www-data -m 750\
 /var/trac

ln -s /var/trac/sites /etc/apache2/sites-trac

cat > /etc/apache2/ports.conf <<PORTS-CONF
# We only listen to 80, as SSL Termination is implemented by
# the reverseproxy.
Listen 80
PORTS-CONF

sed -i -e '
/IncludeOptional sites-enabled[/][*][.]conf/a\
IncludeOptional sites-trac/*.conf

/<Directory [/]srv[/]>/i\
<Directory /var/trac/www/>\
        Options Indexes FollowSymLinks\
        AllowOverride None\
        Require all granted\
</Directory>\
' /etc/apache2/apache2.conf

cat >> /etc/apache2/apache2.conf <<APACHE

<Location "/server-status">
    SetHandler server-status
    Require all granted
</Location>
APACHE
