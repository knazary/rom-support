require 'backports'
require 'backports/basic_object' unless defined?(BasicObject)
require 'rubygems'

require 'pp'
require 'ostruct'
require 'dm-mapper'
require 'virtus'

require 'data_mapper/engine/veritas'

require 'rspec'

%w(shared support).each do |name|
  Dir[File.expand_path("../#{name}/**/*.rb", __FILE__)].each { |file| require file }
end

RSpec.configure do |config|

  config.before(:each) do
    if example.metadata[:example_group][:file_path] =~ /unit|shared/
      @test_env = TestEnv.instance
    end
  end

  config.after(:each) do
    if example.metadata[:example_group][:file_path] =~ /unit|shared/
      @test_env.clear!
    end
  end

  config.include(SpecHelper)
end

include DataMapper

DM_ENV = Environment.new

TEST_ENGINE = TestEngine.new('db://localhost/test')

DM_ENV.engines[:test] = TEST_ENGINE
