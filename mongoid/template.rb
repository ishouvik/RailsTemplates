# Add the current directory to the path Thor uses
# to look up files
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

template 'Gemfile.tt', :force => true
copy_file 'config/mongoid.yml', :force => true
template  'test/test_helper.rb.tt', :force => true
copy_file 'app/assets/stylesheets/application.scss', :force => true
copy_file 'Procfile', :force => true
copy_file '.env'

after_bundle do
  run 'bundle exec guard init'
  generate 'forgery'

  remove_file 'app/assets/javascripts/application.js'
  run 'rails g layout:install bootstrap3'
  remove_file 'app/assets/stylesheets/application.css'

  run 'rails g simple_form:install'
  run 'rails g simple_form:install --bootstrap'

  generate 'controller static_pages home'
  route "root to: 'static_pages#home'"

  run 'git init'
  run 'git add --all'
  run 'git commit -m "Intial commit"'
  puts "\n================ APPLICATION GENERATED. PLEASE UPDATE THE .env FILE AT THE ROOT OF YOUR NEW APPLICATION ================\n"
end
