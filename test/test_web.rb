require 'test_helper'
require 'rack/test'

require 'elephant/web'

ENV['RACK_ENV'] = 'test'

class WebInterfaceTest < MiniTest::Unit::TestCase

  describe 'the elephant web interface' do
    include Rack::Test::Methods

    def app
      Elephant::Web
    end

    it 'should show basic database info' do
      get '/'
      assert last_response.ok?
    end
  end
end
