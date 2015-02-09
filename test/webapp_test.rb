require "test_helper"
require "rack/test"
require "elephant/web"

ENV["RACK_ENV"] = "test"

describe "the elephant web interface" do
  include Rack::Test::Methods

  def app
    Elephant::Web
  end

  it "shows basic database info" do
    get "/"
    assert last_response.ok?
  end
end
