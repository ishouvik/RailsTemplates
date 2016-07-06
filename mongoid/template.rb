# Add the current directory to the path Thor uses
# to look up files
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

# Add gems to Gemfile
gem 'unicorn'
gem 'mongoid', '~> 5.1.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'simple_form'
gem 'kaminari'

gem_group :development do
  gem 'rails_layout'
end

gem_group :development, :test do
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-livereload'
end


after_bundle do
  run 'bundle exec guard init'
  puts "\n================ GUARDFILE GENERATED ================\n"

  run 'rails g mongoid:config'
  puts "\n================ MONGOID CONFIG FILE GENERATED ================\n"

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

  copy_file 'Dockerfile'
  copy_file 'docker-compose-yml'
  copy_file 'production.env'
  puts "\n================ DOCKER READY ================\n"
end
