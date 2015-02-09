require "test_helper"

describe "when connecting via DATABASE_URL" do

  it "connects to the test database using the pg driver directly" do
    connection = Elephant::ConnectionAdapter.new

    assert connection.alive?, "Connection must be alive"
    refute connection.active_record?, "Connection must not be active record"
  end
end

describe "with ActiveRecord around" do

  before do
    require "yaml"
    require "active_record"

    @db_url = ENV.delete("DATABASE_URL")
    config_file = File.expand_path("config.yml", File.dirname(__FILE__))

    unless File.exist?(config_file)
      puts "Please copy test/config.yml to test/config.yml.example and edit accordingly"
      abort
    end

    ActiveRecord::Base.establish_connection(YAML::load(File.open(config_file)))
    ActiveRecord::Base.connection.execute("SELECT 1")
  end

  after do
    ENV["DATABASE_URL"] = @db_url
  end

  it "connects to the test database using AR" do
    connection = Elephant::ConnectionAdapter.new

    assert connection.alive?, "Connection must be alive"
    assert connection.active_record?, "Connection must be active record"
  end

  it "does not use active record when disabled in the configuration" do
    Elephant.configure do |c|
      c.disable_ar = true
    end

    assert_raises ArgumentError do
      Elephant::ConnectionAdapter.new
    end
  end
end
