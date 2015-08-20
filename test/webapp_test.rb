require "test_helper"
require "rack/test"
require "elefant/web"

ENV["RACK_ENV"] = "test"

describe "the elefant web interface" do
  include Rack::Test::Methods

  def app
    Elefant::Web
  end

  it "redirects to the summary on the index page" do
    get "/"

    assert last_response.redirect?
    assert last_response.location.match("/summary")
  end

  it "shows a database summary" do
    get "/summary"
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
