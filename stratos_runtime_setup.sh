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

# stratos version
STRATOS_VERSION=4.0.0-SNAPSHOT

# the directory containing the products
PROD_DIR=/home/vagrant/incubator-stratos/products/

# the stratos installer folder
STRATOS_PACK_DIR=/home/vagrant/stratos_installer

PRODUCTS=(
   cloud-controller/modules/distribution/target/apache-stratos-cc-${STRATOS_VERSION}.zip
   stratos-controller/modules/distribution/target/apache-stratos-sc-${STRATOS_VERSION}.zip
   load-balancer/modules/distribution/target/apache-stratos-load-balancer-${STRATOS_VERSION}.zip
   cartridge-agent/modules/distribution/target/apache-stratos-cartridge-agent-${STRATOS_VERSION}-bin.zip 
   stratos-cli/distribution/target/apache-stratos-cli-${STRATOS_VERSION}.zip
)

# mkdir if it doesn't exist
[ -d ${STRATOS_PACK_DIR} ] || mkdir $STRATOS_PACK_DIR

for item in ${PRODUCTS[*]}
do
   cp ${PROD_DIR}${item} ${STRATOS_PACK_DIR} 
done

wget -nv -c -P /vagrant/downloads/ http://dist.wso2.org/downloads/message-broker/2.1.0/rc1/wso2mb-2.1.0.zip 
pushd `pwd`
cd $STRATOS_PACK_DIR
unzip /vagrant/downloads/wso2mb-2.1.0.zip
popd

chown -R vagrant:vagrant $STRATOS_PACK_DIR