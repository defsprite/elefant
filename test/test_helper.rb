$: << File.expand_path("lib")
$: << File.expand_path("test")

require "bundler"
Bundler.setup :default, :test

ENV["DATABASE_URL"] ||= "postgres:///elephant_test"

require "elephant"
require "minitest/autorun"

class PGTest < Minitest::Test

  def setup
    init_db
  end

  def teardown
    reset_db
  end

  def init_db
    c = Elephant::ConnectionAdapter.new.execute(File.read('./test/fixtures/test_models.sql'))
    c.disconnect
  end

  def reset_db
    c = Elephant::ConnectionAdapter.new.execute(File.read('./test/fixtures/teardown.sql'))
    c.disconnect
  end
end
