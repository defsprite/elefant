require "test_helper"

describe "ActiveRecord being loaded" do

  fork do
    before do
      @db_url = ENV.delete("DATABASE_URL")
      config_file = File.expand_path("config.yml", File.dirname(__FILE__))

      require "active_record"

      unless File.exist?(config_file)
        puts "Please copy test/config.yml to test/config.yml.example and edit accordingly"
        abort
      end

      ActiveRecord::Base.establish_connection(YAML::load(File.open(config_file)))
      ActiveRecord::Base.connection.execute("SELECT 1")

      @old_ar_config_value = Elephant.configuration.disable_ar
    end

    after do
      ENV["DATABASE_URL"] = @db_url

      Elephant.configure do |c|
        c.disable_ar = @old_ar_config_value
      end
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

  it "runs the ar specs successfully" do
    Process.wait
    exit_status = $?.to_i

    assert_equal 0, exit_status
  end
end
