#!/bin/bash

source .env

if [ "${DEBUG}" == "true" ]; then
        set -x
fi

# Build Docker image
CMD="docker image build ${BUILD_OPTS} -t ${REGISTRY}${IMAGE}${TAG} ."
if [ "${VERBOSE}" == "true" ]; then
	echo "${CMD}"
fi
if [ "${DRY_RUN}" == "false" ]; then
	eval "${CMD}"
fi

if [ "${DEBUG}" == "true" ]; then
        set +x
fi
#diğer script daha karışık olduğu iiçin iki tane build scripti göndermek istedim.
