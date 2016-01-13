source /opt/dcos-cli/cli/bin/env-setup-dev

dcos config set core.email "dcos"
dcos config set core.reporting "false"
dcos config set package.cache /tmp/dcos
dcos config set package.sources '["https://github.com/mesosphere/universe/archive/version-1.x.zip"]'
dcos config prepend package.sources http://riak-tools.s3.amazonaws.com/riak-mesos/dcos-repo-0.3.0.zip
dcos package update

dcos config set marathon.url $MARATHON_URL
dcos config set core.mesos_master_url $MESOS_URL
dcos config set core.dcos_url $DCOS_URL

