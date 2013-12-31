#!/bin/bash
# --------------------------------------------------------------
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------

set -e
set -x

if [ -f /etc/openstack_provisioned_date ]
then
   exit 0 
fi

sudo yum install -y http://rdo.fedorapeople.org/rdo-release.rpm
sudo yum install -y openstack-packstack expect

expect << EOF
set timeout -1
spawn "/usr/bin/packstack" "--allinone"
expect "Setting up ssh keys...root@10.0.2.15's password:"
send "vagrant\n"
expect eof
EOF

date > /etc/openstack_provisioned_date
