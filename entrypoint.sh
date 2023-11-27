#!/bin/bash

# Install build environment

# execute supplied command or default to interactive bash shell
if [ "$#" = 0 ]; then
    exec bash
else
    exec "$@"
fi
