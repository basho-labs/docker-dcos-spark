#!/bin/bash
source /opt/dcos-cli/cli/bin/env-setup-dev

# To prevent the prompt for registering a token
dcos config set core.email "dcos"
dcos config set core.reporting "false"

# Update package sources
dcos config set package.cache /tmp/dcos
dcos config set package.sources '["https://github.com/mesosphere/universe/archive/version-1.x.zip"]'
dcos config prepend package.sources https://github.com/basho-labs/riak-mesos-dcos-repo/archive/0.3.1.zip
dcos package update

# Install base utilties to get cli commands
dcos package install --cli --yes riak
dcos package install --cli --yes kafka
