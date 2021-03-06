# Add the current directory to the path Thor uses
# to look up files
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

gem_group :development, :test do
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'minitest-rails'
  gem 'factory_girl_rails'
  gem 'forgery'
  gem 'rantly'
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-livereload'
end

gem_group :production do
  gem 'rails_12factor'
end

database_type = ask("Choice of database? [1] Pg | [2] MySQL ")

if database_type == "2"
  gem 'mysql2'
else
  gem 'pg'
end

bootstrap_library = ask('Add Bootstrap? [1] Yes | [2] No')

if bootstrap_library == '1'
  gem 'bootstrap-sass', '~> 3.3.6'

  gem_group :development do
    gem 'rails_layout'
  end
end

gem 'simple_form'
gem 'kaminari'

# Remove Sqlite3 from Gemfile
gsub_file 'Gemfile', /gem 'sqlite3'\n/, ''

# Remove commented statements from Gemfile
gsub_file 'Gemfile', /^\s*#.*\n/, ''

after_bundle do
  run 'bundle exec guard init'
  puts "\n================ GUARDFILE GENERATED ================\n"

  copy_file '.env'
  puts "\n================ ENV FILE GENERATED ================\n"

  remove_file 'config/database.yml'

  if database_type == "2"
    copy_file 'config/mysql/database.yml', 'config/database.yml'
  else
    copy_file 'config/postgresql/database.yml', 'config/database.yml'
  end
  puts "\n================ DATABASE CONFIG GENERATED ================\n"

  remove_file 'test/test_helper.rb'
  copy_file   'test/test_helper.rb'
  puts "\n================ TEST HELPER GENERATED ================\n"

  run "spring stop"

  generate "forgery"
  puts "\n================ FORGERY DICTIONARIES GENERATED ================\n"

  copy_file 'Procfile'
  puts "\n================ PROCFILE GENERATED ================\n"

  run 'rails g simple_form:install'
  puts "\n================ SIMPLEFORM INITIALIZERS GENERATED ================\n"

  if bootstrap_library == '1'
    remove_file 'app/assets/javascripts/application.js'
    run 'rails g layout:install bootstrap3'
    remove_file 'app/assets/stylesheets/application.css'
    copy_file 'app/assets/stylesheets/application.scss'
    run 'rails g simple_form:install --bootstrap'
    puts "\n================ RAILS LAYOUT GENERATED ================\n"
  end

  generate 'controller static_pages home'
  route "root to: 'static_pages#home'"
  puts "\n================ APPLICATION ROOT GENERATED ================\n"

  copy_file 'Dockerfile'
  copy_file 'docker-compose.yml'
  copy_file 'docker-compose.production.yml'
  copy_file 'bin/www/init.sh'
  run 'chmod +x bin/www/init.sh'
  puts "\n================ INITIALIZED DOCKER ================\n"

  run 'git init'
  run 'git add --all'
  run 'git commit -m "Intial commit"'
  remove_file '.gitignore'
  copy_file '.gitignore.example', '.gitignore'
  puts "\n================ GIT INITIALIZED ================\n"
end
