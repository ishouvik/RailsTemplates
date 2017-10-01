# iShouvik Rails Templates: ActiveRecord
This is an easy to use Rails template for ActiveRecord.

Please, feel to use the templates for your Rails apps and suggest chnages in the [issues](https://github.com/ishouvik/RailsTemplates/issues) section

## What's included
- Pg/MySQL
- Bootstrap layout using *Bootstrap SaaS* and *RailsLayout*
- SimpleForm
- Kaminari
- Dotenv-Rails
- Better Errors
- Guard, Guard Livereload, Guard Minitest

## Test suite
- Minitest Rails
- Factory Girl
- Forgery
- Rantly

## Usage
- Clone this repo `git clone git@github.com:ishouvik/RailsTemplates.git`
- Generate the application from the *Activerecord* template `rails new myapp -m /RailsTemplates/activerecord/template.rb`
- Change environment variables in **.env** file
- Cleanup the **Gemfile**

# Docker Usage (MySQL)
- Change the `DB_NAME` and `SECRET_KEY_BASE` values on the `.env.` file
- Build and run the container: `docker-compose up -d`
- If you make any change on the `Gemfile`. Force build the docker images for the changes to take place: `docker-compose up -d --build`
- The default port for the app is `5000`

## Feel free to ping me:
- [LinkedIn](https://in.linkedin.com/in/shouvikmukherjee)
- [Twitted: @ishouvik](http://twitter.com/ishouvik)
- [Mail: contact (a) ishouvik.com](mailto:contact@ishouvik.com)

# ToDO
- Add Docker support for Postgresql
