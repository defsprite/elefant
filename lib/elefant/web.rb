require "sinatra"
require "sinatra/partial"
require "i18n"
require "i18n/backend/fallbacks"
require "elefant"

module Elefant
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
      Elefant::Stats.check!
      I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
      I18n.load_path = Dir[File.join(settings.locales, '*.yml')]
      I18n.backend.load_translations
    end

    before do
      @stats ||= Elefant::Stats.new
    end

    after do
      @stats.close!
    end

    helpers do

      def stats
        @stats ||= Elefant::Stats.new
      end

      def get_stats(name, params = [])
        stats.get(name, params)
      end

      def css_for(field)
        I18n.t(field, scope: "css", locale: :en)
      end

      def t(*args, options)
        options.merge!(locale: :en)
        I18n.t(*args, options)
      end

      def link(name, target, params = {})
        extra = params.any? ? "?" + params.map {|k, v| "#{k}=#{v}" }.join("&") : ""
        css = target == current_path ? 'active' : ''
        %Q{<a href="#{root_path}#{target}#{extra}" class="#{css}">#{name}</a>}
      end

      def root_path
        %Q{#{env['SCRIPT_NAME']}/}
      end

      def current_path
        @current_path ||= request.path_info.gsub(/^\//,'')
      end
    end

    get "/" do
      redirect "#{root_path}summary", 302
    end

    get "/:name" do
      name = params[:name]
      if %w(activity indices size summary tables).include?(name)
        erb name.to_sym
      else
        not_found do
          "Page not found! Sorry."
        end
      end
    end

  end
end
