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

#base setup
ARG BASE_REGISTRY=registry1.dso.mil
ARG BASE_IMAGE=ironbank/redhat/ubi/ubi8-minimal
ARG BASE_TAG=8.4

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG} as base
#FROM registry.access.redhat.com/ubi8/ubi-minimal:8.4-205 as base

#remove if there is no need to have scloud in this build
ARG SCLOUD_URL
ENV SCLOUD_URL=https://github.com/splunk/splunk-cloud-sdk-go/releases/download/v1.7.0/scloud_v4.0.0_linux_amd64.tar.gz 
ENV PYTHON_VERSION=3.7.10 \
    PYTHON_GPG_KEY_ID=0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D

COPY scripts/install.sh /install.sh

RUN mkdir /licenses 
COPY apache-2.0.txt /licenses/apache-2.0.txt
COPY EULA_Red_Hat_Universal_Base_Image_English_20190422.pdf /licenses/EULA_Red_Hat_Universal_Base_Image_English_20190422.pdf
COPY requests-2.25.1.tar.gz requests-2.25.1.tar.gz
COPY Jinja2-3.0.0.tar.gz Jinja2-3.0.0.tar.gz
COPY urllib3-1.26.5.tar.gz urllib3-1.26.5.tar.gz
COPY chardet-4.0.0.tar.gz chardet-4.0.0.tar.gz
COPY certifi-2020.12.5.tar.gz certifi-2020.12.5.tar.gz
COPY idna-3.1.tar.gz idna-3.1.tar.gz
COPY cryptography-3.4.7-cp36-abi3-manylinux2014_x86_64.whl cryptography-3.4.7-cp36-abi3-manylinux2014_x86_64.whl
COPY MarkupSafe-2.0.1.tar.gz MarkupSafe-2.0.1.tar.gz
COPY six-1.16.0.tar.gz six-1.16.0.tar.gz
COPY cffi-1.14.5.tar.gz cffi-1.14.5.tar.gz
COPY pycparser-2.20.tar.gz pycparser-2.20.tar.gz
COPY Python-3.7.10.tgz /tmp/python.tgz
COPY wheel-0.36.2.tar.gz wheel-0.36.2.tar.gz
COPY jmespath-0.10.0.tar.gz jmespath-0.10.0.tar.gz
COPY PyYAML-5.4.1-cp37-cp37m-manylinux1_x86_64.whl PyYAML-5.4.1-cp37-cp37m-manylinux1_x86_64.whl
COPY ansible-4.6.0.tar.gz ansible-4.6.0.tar.gz
COPY ansible-core-2.11.6.tar.gz ansible-core-2.11.6.tar.gz
COPY packaging-20.9-py2.py3-none-any.whl packaging-20.9-py2.py3-none-any.whl
COPY resolvelib-0.5.4-py2.py3-none-any.whl resolvelib-0.5.4-py2.py3-none-any.whl
COPY pyparsing-2.4.7.tar.gz pyparsing-2.4.7.tar.gz

RUN /install.sh && rm -rf /install.sh 

#Install scloud
COPY scloud_v7.1.0_linux_amd64.tar.gz /usr/bin/scloud.tar.gz
RUN tar -zxf /usr/bin/scloud.tar.gz -C /usr/bin/ && rm /usr/bin/scloud.tar.gz

#end base setup

ARG SPLUNK_PRODUCT=splunk
ARG SPLUNK_VERSION=8.2.3
ARG SPLUNK_BUILD=cd0848707637
ARG SPLUNK_ARCH=x86_64
ARG SPLUNK_LINUX_FILENAME=splunk-${SPLUNK_VERSION}-${SPLUNK_BUILD}-Linux-${SPLUNK_ARCH}.tgz

# Get and unpack Splunk Enterprise
#
FROM base as package
COPY scripts/make-minimal-exclude.py /tmp
ENV SPLUNK_BUILD_URL=https://download.splunk.com/products/${SPLUNK_PRODUCT}/releases/${SPLUNK_VERSION}/linux/${SPLUNK_LINUX_FILENAME}
RUN python /tmp/make-minimal-exclude.py $SPLUNK_BUILD_URL > /tmp/splunk-minimal-exclude.list
COPY splunk-8.2.3-cd0848707637-Linux-x86_64.tgz /tmp/splunk.tgz
RUN mkdir -p /minimal/splunk/var /extras/splunk/var
RUN tar -C /minimal/splunk --strip 1 --exclude-from=/tmp/splunk-minimal-exclude.list -zxf /tmp/splunk.tgz
RUN tar -C /extras/splunk --strip 1 --wildcards --files-from=/tmp/splunk-minimal-exclude.list -zxf /tmp/splunk.tgz
RUN mv /minimal/splunk/etc /minimal/splunk-etc
RUN mv /extras/splunk/etc /extras/splunk-etc
RUN mkdir -p /minimal/splunk/etc /minimal/splunk/share/splunk/search_mrsparkle/modules.new
COPY splunk-ansible.tar.gz splunk-ansible.tar.gz
RUN tar -zxf splunk-ansible.tar.gz && mv splunk-ansible-8.2.3 splunk-ansible-develop && rm splunk-ansible.tar.gz

#
# Minimal Splunk base image with many files excluded, intended for internal and experimental use
#
FROM base as minimal
ENV SPLUNK_HOME=/opt/splunk \
    SPLUNK_GROUP=splunk \
    SPLUNK_USER=splunk
ENV TMPSPLUNKDIR=${SPLUNK_HOME}/tmp
ENV TMPETCDIR=${TMPSPLUNKDIR}/etc

# Currently kubernetes only accepts UID and not USER field to
# start a container as a particular user. So we create Splunk
# user with pre-determined UID.
ARG UID=41812
ARG GID=41812

# Simple script used to populate/upgrade splunk/etc directory
COPY scripts/updateetc.sh /sbin/updateetc.sh

# Setup users and groups
RUN groupadd -r -g ${GID} ${SPLUNK_GROUP} \
    && useradd -r -m -u ${UID} -g ${GID} ${SPLUNK_USER} \
    && chmod 755 /sbin/updateetc.sh

COPY --from=package --chown=splunk:splunk /minimal /opt

USER ${SPLUNK_USER}
WORKDIR ${SPLUNK_HOME}
EXPOSE 8000/tcp 8089/tcp

#
# Bare Splunk Enterprise Image without Ansible (BYO entrypoint)
#
FROM minimal as bare
COPY --from=package --chown=splunk:splunk /extras /opt
#remove unneeded packages that were vulnerable
RUN rm -fdr /opt/splunk/etc/apps/splunk_archiver /opt/splunk/bin/jars/thirdparty/hive /opt/splunk/bin/jars/thirdparty/hive_2_2 /opt/splunk/bin/jars/thirdparty/hive_3_1 /opt/splunk/bin/jars/vendors/spark /opt/splunk/bin/jars/thirdparty/common/commons-io-2.4.jar /opt/splunk/bin/jars/thirdparty/aws/commons-codec-1.7.jar /opt/splunk/bin/jars/vendors/libs/json-smart-2.3.jar /opt/splunk/bin/jars/thirdparty/hive_1_2
COPY scripts/delete_jquery.py /delete_jquery.py
RUN python /delete_jquery.py
EXPOSE 8000 8065 8088 8089 8191 9887 9997
VOLUME [ "/opt/splunk/etc", "/opt/splunk/var" ]

#
# Full Splunk Enterprise Image with Ansible
#
FROM bare

ARG SPLUNK_DEFAULTS_URL

ENV SPLUNK_ROLE=splunk_standalone \
    SPLUNK_DEFAULTS_URL=${SPLUNK_DEFAULTS_URL} \
    SPLUNK_ANSIBLE_HOME=/opt/ansible \
    ANSIBLE_USER=ansible \
    ANSIBLE_GROUP=ansible \
    CONTAINER_ARTIFACT_DIR=/opt/container_artifact

USER root

COPY [ "scripts/entrypoint.sh", "scripts/createdefaults.py", "scripts/checkstate.sh", "/sbin/" ]
COPY --from=package  /splunk-ansible-develop ./splunk-ansible-develop

# Set sudo rights
RUN echo 'Create the ansible user/group' \
    && groupadd -r ${ANSIBLE_GROUP} \
    && useradd -r -m -g ${ANSIBLE_GROUP} ${ANSIBLE_USER} \
    && usermod -aG sudo ${ANSIBLE_USER} \
    && usermod -aG ${ANSIBLE_GROUP} ${SPLUNK_USER} \
    && echo 'Container Artifact Directory is a place for all artifacts and logs that are generated by the provisioning process. The directory is owned by the user "ansible".' \
    && mkdir ${CONTAINER_ARTIFACT_DIR} \
    && chown -R ${ANSIBLE_USER}:${ANSIBLE_GROUP} ${CONTAINER_ARTIFACT_DIR} \
    && chmod -R 775 ${CONTAINER_ARTIFACT_DIR} \
    && mv splunk-ansible-develop ${SPLUNK_ANSIBLE_HOME} \
    && chmod -R 555 ${SPLUNK_ANSIBLE_HOME} \
    && chgrp ${ANSIBLE_GROUP} ${SPLUNK_ANSIBLE_HOME} ${SPLUNK_ANSIBLE_HOME}/ansible.cfg \
    && chmod 775 ${SPLUNK_ANSIBLE_HOME} \
    && chmod 664 ${SPLUNK_ANSIBLE_HOME}/ansible.cfg \
    && chmod 755 /sbin/entrypoint.sh /sbin/createdefaults.py /sbin/checkstate.sh
RUN microdnf remove -y shadow-utils

#STIG the instance
COPY ubi8-development.tar.gz /ubi8-development.tar.gz
RUN tar -zxvf /ubi8-development.tar.gz
RUN ubi8-development/scripts/xccdf_org.ssgproject.content_rule_disable_ctrlaltdel_burstaction.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_max_concurrent_login_sessions.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_maxclassrepeat.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_dcredit.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_ocredit.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_lcredit.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_maxrepeat.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_ucredit.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_minlen.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_difok.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_unlock_time.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_unix_remember.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_deny.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_interval.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_disable_users_coredumps.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_minlen_login_defs.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_display_login_attempts.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_pwhistory_remember_password_auth.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_pwhistory_remember_system_auth.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_passwords_pam_faillock_deny_root.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_accounts_password_pam_minclass.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_file_groupownership_system_commands_dirs.sh && \
    ubi8-development/scripts/xccdf_org.ssgproject.content_rule_account_disable_post_pw_expiration.sh
RUN rm -fdr ubi8-development
RUN grep -rl -e "-BEGIN.*PRIVATE KEY-" /opt/splunk-etc/apps | while read line; do rm -f "$line";done;
RUN grep -rl -e "-BEGIN.*PRIVATE KEY-" /opt/splunk | while read line; do rm -f "$line";done;
RUN microdnf remove -y findutils

USER ${SPLUNK_USER}
HEALTHCHECK --interval=30s --timeout=30s --start-period=3m --retries=5 CMD /sbin/checkstate.sh || exit 1
ENTRYPOINT [ "/sbin/entrypoint.sh" ]
CMD [ "start-service" ]
