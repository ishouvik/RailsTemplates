# Add the current directory to the path Thor uses
# to look up files
def source_paths
  Array(super) +
    [File.expand_path(File.dirname(__FILE__))]
end

def apply_template!
  template "Gemfile.tt", :force => true
  template   'test/test_helper.rb.tt', :force => true
  copy_file 'app/assets/stylesheets/application.scss', :force => true
  copy_file 'Procfile', :force => true
  copy_file '.env.example'
end

apply_template!

after_bundle do
  run 'bundle exec guard init'
  copy_file '.env'
  run 'rails g mongoid:config'
  generate "forgery"

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
  puts "\n================ ENV FILE GENERATED ================\n"
end
