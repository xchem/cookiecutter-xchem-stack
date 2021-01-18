# cookiecutter-xchem-stack Template

## Using the Template

To run the template you need to create an environment that has both django and cookiecutter instead.

From the commandline run and fill in the prompts.

```
cookiecutter https://github.com/xchem/cookiecutter-xchem-stack
```

### Creating a secret key

Since I don't know how to make the template create a key itself. You will have to generate one randomly.
In Python:

```
from django.utils.crypto import get_random_string
print(get_random_string(50))
```

And then copy this value into the corresponding area in the `settings.py` file in the stack folder.

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
