require "sinatra"
require "sinatra/partial"
require "elephant"

module Elephant
  class Web < Sinatra::Base
    register Sinatra::Partial

    dir = File.expand_path(File.dirname(__FILE__) + "/../../web")

    set :public_folder, "#{dir}/public"
    set :views, "#{dir}/views"
    set :root, "#{dir}/public"
    # set :locales, "#{dir}/locales"

    set :partial_template_engine, :erb
    set :layout_engine, :erb

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

      def field_stats(name, fields = [["*"]])
        stats.get(name, fields)
      end

      def param_stats(name, params = [])
        stats.get(name, params)
      end

      def table_helper(fields, results)
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

    get "/load" do
      erb :load
    end

    get "/size" do
      erb :size
    end

  end
end
