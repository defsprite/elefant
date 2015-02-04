module Elephant::Postgres

  module StatQueries

    module Activity
      VIEW = 'pg_stat_activity'
      FIELDS = %w(datid datname usename application_name client_addr client_hostname client_port backend_start xact_start query_start waiting)
      QUERY = "SELECT #{FIELDS * ', '} FROM #{VIEW}"
    end

    module Tables
      FIELDS = %w(relid schemaname relname seq_scan seq_tup_read idx_scan idx_tup_fetch n_tup_ins n_tup_upd n_tup_del n_tup_hot_upd n_live_tup n_dead_tup last_vacuum last_autovacuum last_analyze last_autoanalyze vacuum_count autovacuum_count analyze_count autoanalyze_count)
      QUERY = "SELECT #{FIELDS * ', '} FROM pg_stat_user_tables;"
    end

    # IO_TABLES   = "SELECT * FROM pg_statio_user_tables;"
    module Indices
      FIELDS = %w(relid indexrelid schemaname relname indexrelname idx_scan idx_tup_read idx_tup_fetch)
      QUERY = "SELECT #{FIELDS * ', '} FROM pg_stat_user_indexes;"
    end

    #IO_INDEXES  = "SELECT * FROM pg_statio_user_indexes;"
    #IO_SEQUENCES= "SELECT * FROM pg_statio_user_sequences;"

  end

end
