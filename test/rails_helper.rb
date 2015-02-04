require 'minitest/autorun'
require 'minitest/pride'

require File.expand_path('../lib/elephant.rb', File.dirname(__FILE__))

require 'yaml'
config_file = File.expand_path('config.yml', File.dirname(__FILE__))

unless File.exist?(config_file)
  puts "Please copy test/config.yml to test/config.yml.example and edit accordingly"
  abort
end

require 'active_record'
ActiveRecord::Base.establish_connection(YAML::load(File.open(config_file)))

require 'elephant'
