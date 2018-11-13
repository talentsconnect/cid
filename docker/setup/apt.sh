### apt.sh -- Setup apt

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

DEBIAN_FRONTEND=noninteractive
export DEBIAN_FRONTEND

apt-get update -y
apt-get upgrade -y
apt-get install -y pinentry-curses
apt-get install -y gnupg2

#
#  NodeSource <gpg@nodesource.com>
#

apt-key add - <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

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
=CLGF
-----END PGP PUBLIC KEY BLOCK-----
EOF


#
# Yarn
#
#
# This key can otherwise be aquired with
#
#   curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg

apt-key add - <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jeDghj400U6pjSUW3bIC/PI=
=gZNT
-----END PGP PUBLIC KEY BLOCK-----
EOF


#
#  Docker Release (CE deb) <docker@docker.com>
#
#
# This key can otherwise be aquired with
#
#   curl -fsSL https://download.docker.com/linux/debian/gpg


apt-key add - <<EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
YT90qFF93M3v01BbxP+EIY2/9tiIPbrd
=0YYh
-----END PGP PUBLIC KEY BLOCK-----
EOF


#
# Jenkins
#

apt-key add - <<JENKINS_IO_KEY
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1

mQGiBEmFQG0RBACXScOxb6BTV6rQE/tcJopAEWsdvmE0jNIRWjDDzB7HovX6Anrq
n7+Vq4spAReSFbBVaYiiOx2cGDymj2dyx2i9NAI/9/cQXJOU+RPdDzHVlO1Edksp
5rKn0cGPWY5sLxRf8s/tO5oyKgwCVgTaB5a8gBHaoGms3nNC4YYf+lqlpwCgjbti
3u1iMIx6Rs+dG0+xw1oi5FUD/2tLJMx7vCUQHhPRupeYFPoD8vWpcbGb5nHfHi4U
8/x4qZspAIwvXtGw0UBHildGpqe9onp22Syadn/7JgMWhHoFw5Ke/rTMlxREL7pa
TiXuagD2G84tjJ66oJP1FigslJzrnG61y85V7THL61OFqDg6IOP4onbsdqHby4VD
zZj9A/9uQxIn5250AGLNpARStAcNPJNJbHOQuv0iF3vnG8uO7/oscB0TYb8/juxr
hs9GdSN0U0BxENR+8KWy5lttpqLMKlKRknQYy34UstQiyFgAQ9Epncu9uIbVDgWt
y7utnqXN033EyYkcWx5EhLAgHkC7wSzeSWABV3JSXN7CeeOif7QiS29oc3VrZSBL
YXdhZ3VjaGkgPGtrQGtvaHN1a2Uub3JnPohjBBMRAgAjAhsDBgsJCAcDAgQVAggD
BBYCAwECHgECF4AFAko/7vYCGQEACgkQm30y8tUFguabhgCgi54IQR4rpJZ/uUHe
ZB879zUWTQwAniQDBO+Zly7Fsvm0Mcvqvl02UzxCiGAEExECACAFAkmFQG0CGwMG
CwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRCbfTLy1QWC5qtXAJ9hPRisOhkexWXJ
nXQMl9cOTvm4LgCdGint1TONoZ2I4JtOiFzOmeP3ju3RzcvNyQEQAAEBAAAAAAAA
AAAAAAAA/9j/4AAQSkZJRgABAQEAYABgAAD/4QBgRXhpZgAASUkqAAgAAAAEADEB
AgAZAAAAPgAAABBRAQABAAAAAUOQABFRBAABAAAAEgsAABJRBAABAAAAEgsAAAAA
AABNYWNyb21lZGlhIEZpcmV3b3JrcyA0LjAAAP/bAEMACAYGBwYFCAcHBwkJCAoM
FA0MCwsMGRITDxQdGh8eHRocHCAkLicgIiwjHBwoNyksMDE0NDQfJzk9ODI8LjM0
Mv/bAEMBCQkJDAsMGA0NGDIhHCEyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMv/AABEIAK4AlgMBIgACEQEDEQH/xAAfAAAB
BQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAAAX0B
AgMABBEFEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUmJygp
KjQ1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaHiImK
kpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj
5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEBAAAAAAAAAQIDBAUGBwgJ
Cgv/xAC1EQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGh
scEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZ
WmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1
tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEA
AhEDEQA/APcBI/8Afb86XzH/AL7fnUYpwqRknmN/fP50u9v7x/OmCgUASb2/vH86
Xe394/nTBS0AP3t/eP50u4+p/OmUopgO3H1NO3H1NR5xThQA7cfWlyfU0ylFMQ/J
9aXPvTKdQAuaM0lLQAtJmiigAzRSdqKAKApwpopc1mUOpRSUopgKKWkFLQAueKzr
zXbCwk2Tzxq3cFwK8v8Aih8V30aaTQ9DKtegYnuTyIvZR3b+VfP1/q17fzvLc3Ms
sjHJZ2JJNGr2HZdT6j8U/FbR/DcKsM3VxLkpGh6AetcI37Ql4Zcx6LAYx2aUgmvD
1ju7obgJHA7nmmmG4TqjDHtS+ZXL1sfVPhT4yeH/ABFNHaXYbS71zhVnYGNz6B+n
4HFejK2RmvhJJSDiTj6ivYvht8XptE8rSPEEklxpxwkFyTue39j6p+op3a3Javsf
RuacDVaC4juIUmhkWSKRQyspyGB7ipgasgfmlpoNLmgBaKSigBaKM0UAUBS0lKKz
KFFLSUooAdWR4o1qLw/4bvtSmZVEMRK57t2H51rCvJPj7etD4WsbQMQJ7jkDuFBN
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
=fBn8
-----END PGP PUBLIC KEY BLOCK-----
JENKINS_IO_KEY


#
# Community PHP Packages
#

# curl https://packages.sury.org/php/apt.gpg | base64 -b 70

apt-key add - <<GPGKEY
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=0VaR
-----END PGP PUBLIC KEY BLOCK-----
GPGKEY


# Install basic packages
#
#  Some utilities, like apt-* and debconf-* are useful for package
#  management, the less pager is very useful, nvi is an old version
#  of vi (355 kB including documentation!) which is useful for basic
#  editing and curl is useful as a general debugging and download
#  tool.
#
#  We also install procps (for ps(1)), curl and netcast as they belong
#  to the docker container toolkit.
#
#  Last wget and lsb-release are dependencies of the mysql-apt-config
#  package used to add repositories needed for mysql.

printf 'APT::Install-Recommends "false";\n'\
       >> /etc/apt/apt.conf.d/90norecommends

apt-get remove cmdtest

apt-get install -y\
  apt-transport-https\
  apt-utils\
  bzip2\
  ca-certificates\
  curl\
  debconf-utils\
  git\
  less\
  lsb-release\
  lsof\
  man\
  net-tools\
  nvi\
  procps\
  ruby-mustache\
  sudo\
  wget\
  xz-utils

cat >> /etc/apt/sources.list <<EOF
deb https://deb.nodesource.com/node_8.x stretch main
deb https://dl.yarnpkg.com/debian/ stable main
deb https://download.docker.com/linux/debian stretch stable
deb https://packages.sury.org/php/ stretch main
deb https://pkg.jenkins.io/debian-stable binary/
deb-src https://deb.nodesource.com/node_8.x stretch main
EOF

apt-get update -y
apt-get upgrade -y
apt-get clean

### End of file `apt.sh'
