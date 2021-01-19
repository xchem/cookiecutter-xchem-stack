# cookiecutter-xchem-stack Template

## Introduction

This template uses [Cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/) to generate boilerplate code needed in XChem's Django/React web applications. It makes it quicker and easier both to set up a development environment for the application, and to deploy it using Docker and Kubernetes.

### The stack includes:
* [Django](https://www.djangoproject.com/) back-end connected to XChemDB
* [Django REST Framework](https://www.django-rest-framework.org/) for web APIs
* [React JS](https://reactjs.org/) front-end
* [Redux](https://redux.js.org/) to manage application state in React
* [Axios](https://www.npmjs.com/package/axios) to handle HTTP requests from the front-end side
* [webpack](https://webpack.js.org/) and [Babel](https://babeljs.io/) [*TODO: purpose*]
* [*TODO - other elements*]

## Using the Template
Make sure you have Python 3, Django and Cookiecutter installed in your environment [*TODO: how about npm or Node?*]. To install Django and Cookiecutter with `pip` you can use:
```
pip install --user cookiecutter
python -m pip install Django
```

( For other installation options or more info, see the official documentation: [Django installation](https://docs.djangoproject.com/en/3.1/topics/install/), [Cookiecutter installation](https://cookiecutter.readthedocs.io/en/1.7.2/installation.html) )

When your environment is ready, navigate to your project directory of choice, and run:

`cookiecutter https://github.com/xchem/cookiecutter-xchem-stack`

You will be prompted to provide some values, with the defaults given in square brackets. To choose a default value, simply press Enter without typing anything.

After providing all the values, you should have a new directory created, named after the `project_name` you just provided. Inside that directory, there will be a `README.md` file. Follow the further setup instructions from that file.

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
