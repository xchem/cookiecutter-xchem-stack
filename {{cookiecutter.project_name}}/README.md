# {{cookiecutter.project_name}}

AUTHOR: {{cookiecutter.project_author}}

LICENSE: {{cookiecutter.project_license}}

## Building the Stack for Development Purposes (for local deployment)

Install python3 and node, both should be available on DLS (I hope).

Generate a secret key to be used by your backend's security features. To get one using Python, run `python`, and inside the interactive session, run the following commands:
```python
from django.utils.crypto import get_random_string
print(get_random_string(50))
```
Copy the random string you obtained.

Now, open `settings.py` in the `{{cookiecutter.project_name}}_stack` folder, and set `SECRET_KEY` to your string (do not forget to wrap it in quotes!). The effect should be something like this:

`SECRET_KEY = '<my_random_string>' `

([More on SECRET_KEY in Django](https://docs.djangoproject.com/en/3.1/ref/settings/#secret-key))

We recommend creating conda environment to handle the pythony stuff. After cookiecutting the template, cd into this directory (where `ls` yields {{cookiecutter.project_name}}, basically where the Dockerfile is aswell.

```bash
# Can use previous environment from cookiecutter
conda create --name <env_name> python=3.8
conda activate <env_name>

pip install django djangorestframework django-rest-knox

npm init -y
npm i -D webpack webpack-cli @babel/core babel-loader @babel/preset-env @babel/preset-react babel-plugin-transform-class-properties
npm i react react-dom prop-types axios react-dom react-redux redux redux-devtools-extension redux-thunk remote-redux-devtools
npm run dev

cd {{cookiecutter.project_name}}
python ./manage.py migrate
python ./manage.py runserver
```
## Integration with XCDB in the development environment
To be able to connect to XCDB, you need the following data and credentials:
* database name 
* user name
* password
* host IP address
* port

Make sure you are connected to the Diamond VPN.

Open `settings.py` file from the `{{cookiecutter.project_name}}/{{cookiecutter.project_name}}_stack` directory.

Make sure the following line (listed under `INSTALLED_APPS`) is commented out:

`'django.contrib.sessions',`

Add the necessary credentials to the DATABASES settings. After your changes, it should be uncommented and look like this:
```python
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "<db name>",
        "USER": "<user name>",
        "PASSWORD": "<password>",
        "HOST": "<ip address>",
        "PORT": "<port number>"
    }
}
```
Save your changes in `settings.py`. 

Open `models.py` file from the `{{cookiecutter.project_name}}/{{cookiecutter.project_name}}_backend` folder. Uncomment the following block of code:
```python
    class Meta:
        app_label = 'xchem_db'
        db_table = 'compounds'
```
and save the changes.

Next, install the psycopg2 package. You can try:

`pip install psycopg2`

or, if that results in errors, the alternative:

`pip install psycopg2-binary`

Navigate to your Django project's root directory (the one where `manage.py` file is located), and run:

`python ./manage.py migrate`

To check if your application is connected to XCDB, start the Django development server:

`python ./manage.py runserver`

If everything went right, the server should print a message ending with:
```
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
```
In your web browser, navigate to: `http://127.0.0.1:8000/` to see the test page. On the top of the page, you should see an example form, and on the bottom, a table with some id numbers and SMILES strings. It may take a few seconds for the test data to appear, so don't worry if you cannot see it the moment the page loads.

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
