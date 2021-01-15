#!/bin/bash
module load pollux
x=$(kubectl get pods | grep -e '{{cookiecutter.project_name}}' | awk '{print $1}')
kubectl delete pod $x
# Print new pods
kubectl get pods