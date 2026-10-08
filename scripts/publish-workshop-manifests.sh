#!/bin/bash -e

usage() {
    echo "usage: ./publish-workshop-defns.sh <container registry url> <repository name> <image tag> <github username> <github token>"
}

IMAGE_REGISTRY=$1
if [[ -z "$IMAGE_REGISTRY" ]]; then
    echo "You need to provide a container registry/org coordinate for the workshop deployment, i.e. ghcr.io/spinguard"
    usage
    exit 1
fi

IMAGE_REPO=$2
if [[ -z "$IMAGE_REPO" ]]; then
    echo "You need to provide a repository name for the workshop deployment, i.e. workshop-tekton"
    usage
    exit 1
fi

IMAGE_TAG=$3
if [[ -z "$IMAGE_TAG" ]]; then
    echo "You need to provide a container image tag"
    usage
    exit 1
fi

GITHUB_USERNAME=$4
if [[ -z "$GITHUB_USERNAME" ]]; then
    echo "You need to provide a github username"
    usage
    exit 1
fi

GITHUB_TOKEN=$5
if [[ -z "$GITHUB_TOKEN" ]]; then
    echo "You need to provide a github token"
    usage
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/../

build_workshop_deployment() {
    if [[ -f /tmp/eduk8s-resources/workshops.yaml ]]; then
        rm /tmp/eduk8s-resources/workshops.yaml
    else
        mkdir -p /tmp/eduk8s-resources
    fi

    for file in ./workshops/*/resources/workshop.yaml; do
        echo "Processing $file"
        echo "---" >> /tmp/eduk8s-resources/workshops.yaml

        cat $file |
            sed "s|\$(image_repository)/|${IMAGE_REGISTRY}/|g"| \
            sed "s|:latest|:${IMAGE_TAG}|g" \
            >> /tmp/eduk8s-resources/workshops.yaml
    done

    echo ""
    echo ""
    cat /tmp/eduk8s-resources/workshops.yaml
}

publish_workhop_defns() {
    echo $GITHUB_TOKEN|docker login ghcr.io -u $GITHUB_USERNAME --password-stdin

    imgpkg push --file "/tmp/eduk8s-resources/workshops.yaml" --image ${IMAGE_REGISTRY}/${IMAGE_REPO}-workshop-manifests:${IMAGE_TAG}
    docker pull ${IMAGE_REGISTRY}/${IMAGE_REPO}-workshop-manifests:${IMAGE_TAG}
    docker tag ${IMAGE_REGISTRY}/${IMAGE_REPO}-workshop-manifests:${IMAGE_TAG} ${IMAGE_REGISTRY}/${IMAGE_REPO}-workshop-manifests:latest
    docker push ${IMAGE_REGISTRY}/${IMAGE_REPO}-workshop-manifests:latest
}

build_workshop_deployment
publish_workhop_defns
