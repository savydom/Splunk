#!/bin/bash
# Copyright 2021 Splunk
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

# reinstalling local en def for now, removed in minimal image https://bugzilla.redhat.com/show_bug.cgi?id=1665251
microdnf -y --nodocs install glibc-langpack-en

#Currently there is no access to the UTF-8 char map, the following command is commented out until
#the base container can generate the locale
#localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

#We get around the gen above by forcing the language install, and then point to it.
export LANG=en_US.utf8

#update all packages to reduce vulnerabilites
microdnf -y --nodocs install sudo shadow-utils procps tar tzdata make gcc \
		     openssl-devel bzip2-devel libffi-devel findutils

microdnf -y --nodocs update gnutls kernel-headers librepo libnghttp2 tzdata nettle
#to account for not using BusyBox
microdnf -y --nodocs install iputils hostname psmisc net-tools bind-utils ncurses findutils 

#Install Python and necessary packages
PY_SHORT=${PYTHON_VERSION%.*}
mkdir -p /tmp/pyinstall
tar -xzC /tmp/pyinstall/ --strip-components=1 -f /tmp/python.tgz
rm /tmp/python.tgz
cd /tmp/pyinstall
./configure --enable-optimizations --prefix=/usr --with-ensurepip=install
make altinstall LDFLAGS="-Wl,--strip-all"
rm -rf /tmp/pyinstall
ln -sf /usr/bin/python${PY_SHORT} /usr/bin/python
ln -sf /usr/bin/pip${PY_SHORT} /usr/bin/pip
# Install splunk-ansible dependencies
cd /
pip --no-cache-dir install --no-deps --no-index cffi-1.14.5.tar.gz six-1.16.0.tar.gz wheel-0.36.2.tar.gz \
	requests-2.25.1.tar.gz cryptography-3.4.7-cp36-abi3-manylinux2014_x86_64.whl \
	jmespath-0.10.0.tar.gz Jinja2-3.0.0.tar.gz MarkupSafe-2.0.1.tar.gz PyYAML-5.4.1-cp37-cp37m-manylinux1_x86_64.whl \
       	pycparser-2.20.tar.gz urllib3-1.26.5.tar.gz chardet-4.0.0.tar.gz certifi-2020.12.5.tar.gz \
	idna-3.1.tar.gz pyparsing-2.4.7.tar.gz packaging-20.9-py2.py3-none-any.whl resolvelib-0.5.4-py2.py3-none-any.whl ansible-core-2.11.6.tar.gz \
        ansible-4.6.0.tar.gz --upgrade
# Remove tests packaged in python libs
find /usr/lib/ -depth \( -type d -a -not -wholename '*/ansible/plugins/test' -a \( -name test -o -name tests -o -name idle_test \) \) -exec rm -rf '{}' \;
find /usr/lib/ -depth \( -type f -a -name '*.pyc' -o -name '*.pyo' -o -name '*.a' \) -exec rm -rf '{}' \;
find /usr/lib/ -depth \( -type f -a -name 'wininst-*.exe' \) -exec rm -rf '{}' \;
ldconfig

microdnf remove -y make gcc openssl-devel bzip2-devel libffi-devel cpp binutils \
                   glibc-devel keyutils-libs-devel krb5-devel libcom_err-devel libselinux-devel \
                   libsepol-devel libverto-devel libxcrypt-devel pcre2-devel zlib-devel
microdnf clean all

#additional STIG steps for OS
systemctl mask ctrl-alt-del.target
sed -i 's/ nullok//g' /etc/pam.d/*

cd /bin
chmod u+s /usr/sbin/ping
groupadd sudo

#Clean
microdnf clean all
rm -rf /install.sh /anaconda-post.log /var/log/anaconda/*
