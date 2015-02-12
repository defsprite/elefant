require "test_helper"

describe "when connecting via DATABASE_URL" do

  it "connects to the test database using the pg driver directly" do
    connection = Elephant::ConnectionAdapter.new

    assert connection.alive?, "Connection must be alive"
    refute connection.active_record?, "Connection must not be active record"
  end
end

