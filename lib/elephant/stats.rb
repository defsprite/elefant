require 'elephant/connection_adapter'
require 'elephant/postgres/stat_queries'

module Elephant

  class Stats

    def initialize
      @connection = Elephant::ConnectionAdapter.new
    end

    def get(name)
      query(name)
    end

    private

    def query(name)
      const = name.capitalize.to_sym

      if Postgres::StatQueries.const_defined?(const)
        mod = Postgres::StatQueries.const_get(const)
        result = @connection.execute(mod::QUERY)
        puts result
        result
      else
        raise ArgumentError.new("Unknown Stats Query: #{name}")
      end
    end
  end
end
