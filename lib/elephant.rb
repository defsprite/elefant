require 'elephant/version'
require 'elephant/connection_adapter'
require 'elephant/stats'

module Elephant

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    configuration = self.configuration
    yield(configuration)
  end

  class Configuration
    attr_accessor :disable_ar
    attr_accessor :connection_options

    def initialize
      @disable_ar = false
      @connection_options = {}
    end

    def as_hash
      @connection_options.merge(:disable_ar => @disable_ar)
    end
  end
end
