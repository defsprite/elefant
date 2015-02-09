require "elephant/version"
require "elephant/stats"

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

    def initialize
      @disable_ar = false
    end
  end
end
