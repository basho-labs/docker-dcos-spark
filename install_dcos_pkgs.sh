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

# Work-around to install DCOS Spark manually to avoid errors in low-memory situations
# Assumes that ~/.docs/subcommands/spark/{version,source,package.json} are in place
# which will be done with the Dockerfile
cd /tmp
curl -O https://s3.amazonaws.com/downloads.mesosphere.io/dcos/spark/dcos_spark-0.4.0_spark_1.5.0_multi_roles_v2_bin_2.4.0-py2.py3-none-any.whl
cd ~/.dcos/subcommands
mkdir spark
cd spark
virtualenv env
source env/bin/activate
pip install --use-wheel /tmp/dcos_spark-0.4.0_spark_1.5.0_multi_roles_v2_bin_2.4.0-py2.py3-none-any.whl
deactivate
