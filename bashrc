# Set ENV vars to sensible defaults if not already set
if [[ -z "$MASTER" ]]; then
  export MASTER="mesos://leader.mesos:7077"
fi
if [[ -z "$MARATHON_URL" ]]; then
  export MARATHON_URL="http://leader.mesos:8080"
fi
if [[ -z "$MESOS_URL" ]]; then
  export MESOS_URL="http://leader.mesos:5050"
fi
if [[ -z "$DCOS_URL" ]]; then
  # First, try to discover the URL, using the deployed shim
  export DCOS_URL="http://$(curl -s $MARATHON_URL/v2/apps/dcos-proxy-shim/tasks | jq '.tasks[] | "\(.host) \(.ports[0])"' | tr ' ' ':' | tr -d '"')"

  if [ "http:" = "$DCOS_URL" ]; then
     export DCOS_URL="http://leader.mesos"
  fi
fi

source /opt/dcos-cli/cli/bin/env-setup-dev

dcos config set marathon.url $MARATHON_URL > /dev/null 2>&1
dcos config set core.mesos_master_url $MESOS_URL > /dev/null 2>&1
dcos config set core.dcos_url $DCOS_URL > /dev/null 2>&1
