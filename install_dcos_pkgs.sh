#!/bin/bash
source /opt/dcos-cli/cli/bin/env-setup-dev

dcos config set core.email "dcos"
dcos config set core.reporting "false"
dcos config set package.cache /tmp/dcos
dcos config prepend package.sources https://github.com/basho-labs/riak-mesos-dcos-repo/archive/0.3.0.zip
dcos package update
