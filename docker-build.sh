#!/bin/bash
set -x
DOCKER_FILE=${1:-Dockerfile}
IMAGE_ID=${2:-cl-tool:latest}
WORKSPACE=${WORKSPACE:=`pwd`}
rm -rf $WORKSPACE/download $WORKSPACE/artifact
mkdir -p $WORKSPACE/download $WORKSPACE/artifact
VERSIONS='gooddata-cl-1.3.1.zip 1.2.73.zip'

for VERSION in $VERSIONS
do
    rm -rf $WORKSPACE/download/* && cd $WORKSPACE/download
    wget https://github.com/gooddata/GoodData-CL/archive/${VERSION}
    unzip ${VERSION}
    cd */ && mvn clean install -U
    cd cli-distro && mvn assembly:assembly
    unzip target/gooddata-cli*.zip -d $WORKSPACE/artifact/
done

cd $WORKSPACE
docker build -t $IMAGE_ID -f $DOCKER_FILE .
