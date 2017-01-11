ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "minitest/autorun"

class Minitest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end
