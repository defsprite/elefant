require 'elephant/connection_adapter'
require 'elephant/postgres/stat_queries'
require 'elephant/postgres/size_queries'

module Elephant
  class Stats
    include Elephant::Postgres::StatQueries
    include Elephant::Postgres::SizeQueries

    def initialize
      @connection = Elephant::ConnectionAdapter.new
    end

    def db_name
      @connection.db_name
    end

    def get(name, params)
      query(name, params)
    end

    def close!
      @connection.disconnect
    end

    private

    def query(name, params)
      method = name.to_sym

      if respond_to?(method)
        query = send(method, *params)
        result = @connection.execute(query)
        puts result
        result
      else
        raise ArgumentError.new("Unknown Stats Query: #{name}")
      end
    end
  end
end
