# Add the current directory to the path Thor uses
# to look up files
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

gem_group :development do
  gem 'rails_layout'
end

gem_group :development, :test do
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-livereload'
  gem 'dotenv-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem_group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'bootstrap-sass', '~> 3.3.6'
gem 'simple_form'
gem 'kaminari'


after_bundle do
  run 'bundle exec guard init'
  puts "\n================ GUARDFILE GENERATED ================\n"

  copy_file '.env'
  puts "\n================ ENV FILE GENERATED ================\n"

  remove_file 'config/database.yml'
  copy_file 'config/database.yml'
  puts "\n================ DATABASE CONFIG GENERATED ================\n"

  copy_file 'Procfile'
  puts "\n================ PROCFILE GENERATED ================\n"

  remove_file 'app/assets/javascripts/application.js'
  run 'rails g layout:install bootstrap3'
  remove_file 'app/assets/stylesheets/application.css'
  copy_file 'app/assets/stylesheets/application.scss'
  puts "\n================ RAILS LAYOUT GENERATED ================\n"

  run 'rails g simple_form:install'
  run 'rails g simple_form:install --bootstrap'
  puts "\n================ SIMPLEFORM INITIALIZERS GENERATED ================\n"

  generate 'controller static_pages home'
  route "root to: 'static_pages#home'"
  puts "\n================ APPLICATION ROOT GENERATED ================\n"

  run 'git init'
  run 'git add --all'
  run 'git commit -m "Intial commit"'
  puts "\n================ GIT INITIALIZED ================\n"
end
