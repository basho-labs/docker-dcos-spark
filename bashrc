source /opt/dcos-cli/cli/bin/env-setup-dev

dcos config set marathon.url $MARATHON_URL
dcos config set core.mesos_master_url $MESOS_URL
dcos config set core.dcos_url $DCOS_URL
