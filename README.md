# Docker DCOS and Spark CLI Image

This creates a Docker image that installs the DCOS CLI and Spark 1.5.2.

You'll want to set up an alias because you need to set a few environment variables:

    > alias dcoscli="docker run -it -e MESOS_URL=http://127.0.0.1:5050 -e MARATHON_URL=http://127.0.0.1:8080 -e DCOS_URL=http://127.0.0.1 jbrisbin/dcoscli"
    > dcoscli
    root@0abbf5a04222:~# dcos node
              HOSTNAME                IP                         ID
    ... DCOS output ...
