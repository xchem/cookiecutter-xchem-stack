FROM nikolaik/python-nodejs:python3.8-nodejs15

# Install Everything
RUN pip install django djangorestframework django-rest-knox

WORKDIR /usr/app
COPY ./ /usr/app

RUN npm init -y
RUN npm i -D webpack webpack-cli @babel/core babel-loader @babel/preset-env @babel/preset-react babel-plugin-transform-class-properties
RUN npm i react react-dom prop-types axios react-dom react-redux redux redux-devtools-extension redux-thunk remote-redux-devtools

RUN npm run dev

RUN cd {{cookiecutter.project_name}}

EXPOSE 8000

RUN python ./manage.py migrate

CMD ['python', 'manage.py', 'runserver', '0.0.0.0:8000']
