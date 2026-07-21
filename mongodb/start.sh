#!/bin/sh
# SPDX-License-Identifier: Apache-2.0

echo 'call start.sh'

cd $(dirname "${0}")
mongod --dbpath ./db --port 27017 --bind_ip_all

echo '... done'
