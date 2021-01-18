FROM nikolaik/python-nodejs:python3.8-nodejs15

# Install Everything
RUN pip install django djangorestframework django-rest-knox
RUN npm init -y
RUN npm i -D webpack webpack-cli @babel/core babel-loader @babel/preset-env @babel/preset-react babel-plugin-transform-class-properties
RUN npm i react react-dom prop-types axios react-dom react-redux redux redux-devtools-extension redux-thunk remote-redux-devtools

RUN cd {{cookiecutter.project_name}}

EXPOSE 8000

RUN npm run dev

CMD ['python', 'manage.py', 'runserver']
