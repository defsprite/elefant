require 'test_helper'

class ConnectionTest < MiniTest::Unit::TestCase

  describe "elephant" do

    it "should be able to connect to the test database using AR" do
      connection = Elephant::Postgres::Connection.new
      assert connection.alive?, 'Connection must be alive'
    end

    it "should be able to connect to the test database using the pg driver directly" do
      config_file = File.expand_path('config.yml', File.dirname(__FILE__))
      config = YAML::load(File.open(config_file))

      connection = Elephant::Postgres::Connection.new(config.merge(:disable_ar => true))
      assert connection.alive?, 'Connection must be alive'
    end
  end
end
