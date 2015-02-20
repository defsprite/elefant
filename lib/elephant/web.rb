require "sinatra"
require "sinatra/partial"
require "i18n"
require "i18n/backend/fallbacks"
require "elephant"

module Elephant
  class Web < Sinatra::Base
    register Sinatra::Partial

    dir = File.expand_path(File.dirname(__FILE__) + "/../../web")

    set :public_folder, "#{dir}/public"
    set :views, "#{dir}/views"
    set :root, "#{dir}/public"
    set :locales, "#{dir}/locales"

    set :partial_template_engine, :erb
    set :layout_engine, :erb

    configure do
      Elephant::Stats.check!
      I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
      I18n.load_path = Dir[File.join(settings.locales, '*.yml')]
      I18n.backend.load_translations
    end

    before do
      @stats ||= Elephant::Stats.new
    end

    after do
      @stats.close!
    end

    helpers do

      def stats
        @stats ||= Elephant::Stats.new
      end

      def get_stats(name, params = [])
        stats.get(name, params)
      end

      def t(*args)
        I18n.t(*args)
      end
    end

    get "/" do
      erb :index
    end

    get "/activity" do
      erb :activity
    end

    get "/indices" do
      erb :indices
    end

    get "/tables" do
      erb :tables
    end

    get "/size" do
      erb :size
    end
  end
end
