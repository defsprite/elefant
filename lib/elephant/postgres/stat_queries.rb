module Elephant::Postgres
  module StatQueries

    def activity(fields)
      select_generic fields, "pg_stat_activity"
    end

    def user_tables(fields)
      select_generic fields, "pg_stat_user_tables"
    end

    def user_indexes(fields)
      select_generic fields, "pg_stat_user_indexes"
    end

    def database(fields)
      select_generic fields, "pg_stat_database"
    end

    def select_generic(fields, name)
      "SELECT #{fields * ', '} FROM #{name}"
    end

    #IO_TABLES   = "SELECT * FROM pg_statio_user_tables;"
    #IO_INDEXES  = "SELECT * FROM pg_statio_user_indexes;"
    #IO_SEQUENCES= "SELECT * FROM pg_statio_user_sequences;"
  end
end
