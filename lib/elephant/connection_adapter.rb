require "uri"
require "pg"

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
        r.each do |t|
          result << t
        end
        result
      rescue PGError => e
        @connection.reset
        raise e
      end
    end

    def disconnect
      begin
        if active_record?
          @connection = nil
          ActiveRecord::Base.clear_active_connections!
        else
          @connection.close
        end
      rescue => e
        #QC.log(:at => "disconnect", :error => e.message)
        raise e
      end
    end

    def alive?
      @connection.query "SELECT 1"
      true
    rescue PGError
      false
    end

    def db_name
      @connection.db
    end

    def postgresql_version
      @connection.server_version
    end

    def active_record?
      defined?(ActiveRecord::Base) == "constant" && ActiveRecord::Base.class == Class && !Elephant.configuration.disable_ar
    end

    private

    def validate!(c)
      return c if c.is_a?(PG::Connection)
      err = "connection must be an instance of PG::Connection, but was #{c.class}"
      raise(ArgumentError, err)
    end

    def establish_new
      #QC.log(:at => "establish_conn")
      connection = if active_record?
                     establish_ar
                   else
                     establish_pg
                   end
      connection.exec("SET application_name = 'Elefant stats gem #{Elephant::VERSION}'")
      connection
    end

    def establish_pg
      PGconn.connect(*normalize_db_url(db_url))
      # if conn.status != PGconn::CONNECTION_OK
      #   log(:error => conn.error)
      # end
    end

    def establish_ar
      # Shucks! This is probably a very bad idea.
      ActiveRecord::Base.connection.send(:instance_variable_get, :@connection)
    end

    def normalize_db_url(url)
      host = url.host
      host = host.gsub(/%2F/i, '/') if host

      [
          host, # host or percent-encoded socket path
          url.port || 5432,
          nil, "", #opts, tty
          url.path.gsub('/', ''), # database name
          url.user,
          url.password
      ]
    end

    def db_url
      return @db_url if defined?(@db_url) && @db_url

      url = ENV["ELEPHANT_DATABASE_URL"] ||
          ENV["DATABASE_URL"] ||
          raise(ArgumentError, "missing ELEPHANT_DATABASE_URL or DATABASE_URL")
      @db_url = URI.parse(url)
    end
  end
end
