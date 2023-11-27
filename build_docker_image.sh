#!/bin/bash
# Script to build builder docker images

_what_i_build="uboot"
_dname_base="${_what_i_build}_bldenv"
_docker_registry="ghcr.io/jto6/"

# Should not need to modify below

die() {
    echo "FATAL: $*"
    exit 1
}

usage() {
    echo "Script to build ${_what_i_build} build docker image"
    echo "Usage:"
    echo "  $0 "
    echo "     [-r <docker registry> DEFAULT=${_docker_registry}]"
    exit 0
}

while getopts  r:h arg
do case $arg in
        r)      _docker_registry="$OPTARG";;
        h)      usage;;
        :)      die "$0: Must supply an argument to -$OPTARG.";;
        \?)     die "Invalid Option -$OPTARG ";;
esac
done

_arch="arm64"
_rel="el9"
_dname=${_dname_base}-${_arch}-${_rel}

# Build build environment image for arm64 and publish if requested
if [[ -z ${_docker_registry} ]]; then
    docker buildx build --platform linux/arm64 -t ${_dname} --load -f Dockerfile .
else
    docker buildx build --platform linux/arm64 -t ${_docker_registry}${_dname} \
           --push -f Dockerfile .
fi

echo "Done!!!"
