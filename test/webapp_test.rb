require "test_helper"
require "rack/test"
require "elephant/web"

ENV["RACK_ENV"] = "test"

describe "the elephant web interface" do
  include Rack::Test::Methods

  def app
    Elephant::Web
  end

  it "shows a database summary" do
    get "/"
    assert last_response.ok?
  end

  it "shows activity info" do
    get "/activity"
    assert last_response.ok?
  end

  it "shows info about indices" do
    get "/indices"
    assert last_response.ok?
  end

  it "shows table info" do
    get "/tables"
    assert last_response.ok?
  end

  it "shows size info" do
    get "/size"
    assert last_response.ok?
  end

end
