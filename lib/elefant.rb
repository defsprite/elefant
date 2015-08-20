require "elefant/version"
require "elefant/stats"

module Elefant

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    configuration = self.configuration
    yield(configuration)
  end

  class Configuration
    attr_accessor :disable_ar

    def initialize
      @disable_ar = false
    end
  end
end
