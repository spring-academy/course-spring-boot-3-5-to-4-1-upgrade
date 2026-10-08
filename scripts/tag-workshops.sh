#!/bin/bash -e

usage() {
    echo "usage: ./tag-workshops.sh <container registry org> <repository name> <git sha> <image tag> <github username> <github token>"
}

REPOSITORY_OWNER=$1
if [[ -z "${REPOSITORY_OWNER}" ]]; then
    echo "You need to provide a container org coordinate for the workshop deployment, i.e. spring-academy"
    usage
    exit 1
fi

REPOSITORY_NAME=$2
if [[ -z "${REPOSITORY_NAME}" ]]; then
    echo "You need to provide a repository name for the workshop deployment, i.e. workshop-tekton"
    usage
    exit 1
fi

SHA=$3
if [[ -z "${SHA}" ]]; then
    echo "You need to provide a git sha"
    usage
    exit 1
fi

TAG=$4
if [[ -z "${TAG}" ]]; then
    echo "You need to provide a container image tag"
    usage
    exit 1
fi

GHCR_USER=$5
if [[ -z "${GHCR_USER}" ]]; then
    echo "You need to provide a github username"
    usage
    exit 1
fi

GHCR_TOKEN=$6
if [[ -z "${GHCR_TOKEN}" ]]; then
    echo "You need to provide a github token"
    usage
    exit 1
fi

login() {
    echo ${GHCR_TOKEN} | docker login ghcr.io --username ${GHCR_USER} --password-stdin
}

tag_manifests() {
    docker pull ghcr.io/${REPOSITORY_OWNER}/${REPOSITORY_NAME}-workshop-manifests:${SHA}
    docker tag ghcr.io/${REPOSITORY_OWNER}/${REPOSITORY_NAME}-workshop-manifests:${SHA} ghcr.io/${REPOSITORY_OWNER}/${REPOSITORY_NAME}-workshop-manifests:${TAG}
    docker push ghcr.io/${REPOSITORY_OWNER}/${REPOSITORY_NAME}-workshop-manifests:${TAG}
}

tag_content() {
    docker pull ghcr.io/${REPOSITORY_OWNER}/${REPOSITORY_NAME}-files:${SHA}
    docker tag ghcr.io/${REPOSITORY_OWNER}/${REPOSITORY_NAME}-files:${SHA} ghcr.io/${REPOSITORY_OWNER}/${REPOSITORY_NAME}-files:${TAG}
    docker push ghcr.io/${REPOSITORY_OWNER}/${REPOSITORY_NAME}-files:${TAG}
}

login
tag_content
tag_manifests