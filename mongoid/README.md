# iShouvik Rails Templates: Mongoid
This is an easy to use Rails template for Mogoid.

Please, feel to use the templates for your Rails apps and suggest chnages in the [issues](https://github.com/ishouvik/RailsTemplates/issues) section

## What's included
- Mongoid
- Bootstrap layout using *Bootstrap SaaS* and *RailsLayout*
- SimpleForm
- Kaminari
- Docker ready

## Usage
- Generate the application from the template `rails new myapp -O -m /path/to/template.rb`
- Set the `SECRET_KEY_BASE` value in **production.env**
- Cleanup the **Gemfile**

## Docker setup
- Make sure you have *Docker compose* -- https://docs.docker.com/compose/
- Build Docker image -- `docker-compose build`
- Run container -- `docker-comose up -d`

The template Generates **Dockerfile** and **docker-compose.yml** files. By default it uses my image `ishouvik/rails-nginx-unicorn:latest` from [DockerHub](https://hub.docker.com/r/ishouvik/rails-nginx-unicorn/). You may make changes as per your requirement


## Feel free to ping me:
- [LinkedIn](https://in.linkedin.com/in/shouvikmukherjee)
- [Twitted: @ishouvik](http://twitter.com/ishouvik)
- [Mail: contact (a) ishouvik.com](mailto:contact@ishouvik.com)
