# {{cookiecutter.project_name}}

AUTHOR: {{cookiecutter.project_author}}

LICENSE: {{cookiecutter.project_license}}


## Building Container and Deploying to Kubernetes
We have included a Framework Dockerfile and Kubernetes yaml file that should work out of box with minor configuration.
If you require additional packages and tools please edit the Docker file as you go to save problems later on.

The kubernetes.yaml file may require some additional tweaking and you will require a namespace etc to ensure stuff can run.

For diamond users you will be allowed to run deployments from your own namespace (your FEDID UID) but you will need to register a DNS domain from Chris to be able to see it!

Additionally, we provide two scripts that will rebuild the Dockerfile and commit to the Diamond GCloud docker registry and another one which will automatically disperse and redeploy kubenetes pods.

Anyway:
To rebuild the Docker image use:
```bash
./rebuild_docker_image.sh
```

To apply the kubenetes config:
```bash
module load pollux
kubectl apply -f kubernetes.yaml
```

To redeploy pods
```bash
./redeploy_pods.sh
```