$: << File.expand_path("lib")
$: << File.expand_path("test")

require "bundler"
Bundler.setup :default, :test

ENV["DATABASE_URL"] ||= "postgres:///elefant_test"

require "elefant"
require "minitest/autorun"

Elefant.configure do |c|
  c.disable_ar = false
end

class PGTest < Minitest::Test

  def setup
    init_db
  end

  def teardown
    reset_db
  end

  def init_db
    c = Elefant::ConnectionAdapter.new
    c.execute(File.read('./test/fixtures/test_models.sql'))
    c.disconnect
  end

  def reset_db
    c = Elefant::ConnectionAdapter.new
    c.execute(File.read('./test/fixtures/teardown.sql'))
    c.disconnect
  end
end
