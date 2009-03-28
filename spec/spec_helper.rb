# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'spec/autorun'
require 'spec/rails'
require File.join(File.dirname(__FILE__), 'blueprint')

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end

def sample_text_terms
  [
    'personal development courses',
    'scotland office',
    'communications team',
    's media',
    'departmental staff',
    'environment food',
    'rural affairs',
    'government departments',
    'vaccinations',
    'northern ireland',
    'vaccination',
    'launch',
    'fertility',
    'cattle',
    '12 months',
    'bulls',
    'sheep',
    'salary',
    'journals'
  ]
end

def sample_text
  <<-TEXT
  To ask the Secretary of State for Scotland what the purpose of his visit to Iceland in November 2008 was; how much the visit cost in each category of expenditure; what meetings he attended; what matters were discussed; and how many officials from  (a) the Scotland Office and  (b) other Government departments accompanied him.To ask the Secretary of State for Scotland which  (a) newspapers,  (b) magazines and  (c) journals his Department has subscriptions to.To ask the Secretary of State for Scotland how many hits his Department's blog has received in each month since its launch.To ask the Secretary of State for Scotland what steps his Department has taken to publicise its blog; and what the cost of such activity was.To ask the Secretary of State for Scotland how many overseas visits Ministers in his Department have undertaken in the last 12 months; to which destinations; and how many departmental staff accompanied the Minister on each occasion.To ask the Secretary of State for Scotland what  (a) training,  (b) coaching and  (c) personal development courses each Minister in his Department has received since 2005; and what the cost of providing this training was.To ask the Secretary of State for Scotland when he plans to answer Questions  (a) 248515 and  (b) 248516 tabled on 13 January 2009, on his Department's blog.To ask the Secretary of State for Environment, Food and Rural Affairs what recent assessment he has made of the effectiveness of vaccinations against bluetongue disease among  (a) sheep and  (b) cattle.To ask the Secretary of State for Environment, Food and Rural Affairs what information his Department holds on the effects of bluetongue vaccination on fertility in bulls. [R]To ask the Secretary of State for Northern Ireland how many members of staff are employed in his Department's media and communications team; when each member of staff was recruited; what the responsibilities of each member of staff are; and what the salary of each member of staff is.To ask the Secretary of State for Wales how many members of staff are employed in his Department's media and communications team; when each member of staff was recruited; what the responsibilities of each member of staff are; and what the salary of each member of staff is.To ask the Chancellor of the Exchequer if he will meet representatives of UK nationals who were depositors with Landsbanki Guernsey to discuss their position.
  TEXT
end
