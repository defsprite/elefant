require 'uri'
require 'pg'

module Elephant
  class ConnectionAdapter

    attr_accessor :connection

    def initialize(connection=nil)
      @connection = connection.nil? ? establish_new : validate!(connection)
    end

    def execute(stmt, *params)
        begin
          params = nil if params.empty?
          r = @connection.exec(stmt, params)
          result = []
          r.each do |t| result << t end
          result
        rescue PGError => e
          @connection.reset
          raise e
        end
    end

    def disconnect
        begin
          @connection.close
        rescue => e
          #QC.log(:at => 'disconnect', :error => e.message)
          raise e
        end
    end

    def alive?
      @connection.alive?
    end

    def db_name
      @connection.db
    end

    private

    def validate!(c)
      return c if c.is_a?(PG::Connection)
      err = "connection must be an instance of PG::Connection, but was #{c.class}"
      raise(ArgumentError, err)
    end

    def establish_new
      #QC.log(:at => "establish_conn")
      conn = PGconn.connect(*normalize_db_url(db_url))
      if conn.status != PGconn::CONNECTION_OK
        # QC.log(:error => conn.error)
      end
      conn.exec("SET application_name = 'Elephant Stats'")
      conn
    end

    def normalize_db_url(url)
      host = url.host
      host = host.gsub(/%2F/i, '/') if host

      [
       host, # host or percent-encoded socket path
       url.port || 5432,
       nil, '', #opts, tty
       url.path.gsub("/",""), # database name
       url.user,
       url.password
      ]
    end

    def db_url
      return @db_url if defined?(@db_url) && @db_url

      url = ENV["ELEPHANT_DATABASE_URL"] ||
            ENV["DATABASE_URL"]    ||
            raise(ArgumentError, "missing ELEPHANT_DATABASE_URL or DATABASE_URL")
      @db_url = URI.parse(url)
    end
  end
end
