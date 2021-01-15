#!/bin/bash
# This script uses podman instead of Docker because that's the RedHat version.
module load pollux # Diamonds Kubernetes deployment (will require logging in once a week)
# podman image prune -a
podman build --rm -t {{cookiecutter.project_name}} .
x=$(podman images | grep -e '{{cookiecutter.project_name}}' | awk '{print $3}')
podman tag $x gcr.io/diamond-privreg/xchemapps/{{cookiecutter.project_name}}:latest
podman push gcr.io/diamond-privreg/xchemapps/{{cookiecutter.project_name}}:latest
echo 'Finished building Container'
