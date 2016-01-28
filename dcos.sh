#!/bin/bash

# Wrapper for the dcos command to be called from docker run

# Setup the DCOS environment if it isn't
if [ -z "${DCOS_CONFIG}" ]; then
    . /root/.bashrc
fi

dcos "$@"
