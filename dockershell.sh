#!/bin/bash

###############################################################################
## Function

log() {
	echo "$(date +"%Y-%m-%dT%H:%M:%S.%03N") - $*"
}

###############################################################################
## Parameters
DOCKER_IMAGE_EXECUTED_LOCALLY='riscv4ice40:local'
REBUILD_IMAGE=false

while getopts "r" opt; do
  case ${opt} in
	r)
        REBUILD_IMAGE=true
      	;;
 	\?)
		echo "Invalid option: -$OPTARG"
		exit 1
		;;
	:)
        echo "The option -$OPTARG requires an argument."
        exit 1
      	;;
  esac
done

if [ "${REBUILD_IMAGE}" = "true" ]; then
	log "erasing ${DOCKER_IMAGE_EXECUTED_LOCALLY}..."	
	docker rmi -f ${DOCKER_IMAGE_EXECUTED_LOCALLY}
fi

if [[ "$(docker images -q ${DOCKER_IMAGE_EXECUTED_LOCALLY} 2> /dev/null)" == "" ]]; then
	log "${DOCKER_IMAGE_EXECUTED_LOCALLY} do no exists! building it..."	
	docker build -f ./.gci/Dockerfile -t ${DOCKER_IMAGE_EXECUTED_LOCALLY} --build-arg ARCH=${ARCH} .
else
	log "yeah! ${DOCKER_IMAGE_EXECUTED_LOCALLY} exists!!"
fi

docker run --rm -it -v $(pwd):/riscv4ice40 -w /riscv4ice40 ${DOCKER_IMAGE_EXECUTED_LOCALLY} /bin/bash
