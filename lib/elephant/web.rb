require 'sinatra'
require 'sinatra/partial'
require 'slim'

module Elephant
  class Web < Sinatra::Base
    register Sinatra::Partial

    dir = File.expand_path(File.dirname(__FILE__) + "/../../web")

    set :public_folder, "#{dir}/public"
    set :views, "#{dir}/views"
    set :root, "#{dir}/public"
    # set :locales, "#{dir}/locales"

    set :slim, :pretty => true
    set :partial_template_engine, :slim
    set :layout_engine, :slim

    helpers do

      def stats(name)
        @stats ||= Elephant::Stats.new
        @stats.get(name)
      end

      def table_helper(fields, results)
      end

    end

    get '/' do
      @rows = stats('tables')
      slim :index
    end

    get '/activity' do
      @rows = stats('activity')
      slim :activity
    end

    get '/indices' do
      @rows = stats('indices')
      slim :indices
    end

    get '/test' do
      slim :test
    end

  end
end
