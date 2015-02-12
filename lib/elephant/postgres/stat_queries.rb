module Elephant::Postgres
  module StatQueries

    def initialize(connection)
      @connection = connection
    end

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
      exec "SELECT #{fields * ", "} FROM #{name}"
    end

    def summary
      res = exec %Q{
			SELECT
        now()                          AS db_time,
				MAX(stat_db.xact_commit)       AS commits,
				MAX(stat_db.xact_rollback)     AS rollbks,
				MAX(stat_db.blks_read)         AS blksrd,
				MAX(stat_db.blks_hit)          AS blkshit,
				MAX(stat_db.numbackends)       AS bkends,
				SUM(stat_tables.seq_scan)      AS seqscan,
				SUM(stat_tables.seq_tup_read)  AS seqtprd,
				SUM(stat_tables.idx_scan)      AS idxscn,
				SUM(stat_tables.idx_tup_fetch) AS idxtrd,
				SUM(stat_tables.n_tup_ins)     AS ins,
				SUM(stat_tables.n_tup_upd)     AS upd,
				SUM(stat_tables.n_tup_del)     AS del,
				MAX(stat_locks.locks)          AS locks,
				MAX(activity.sess)             AS activeq
			FROM
				pg_stat_database    AS stat_db,
				pg_stat_user_tables AS stat_tables,
				(SELECT COUNT(*) AS locks FROM pg_locks ) AS stat_locks,
				(SELECT COUNT(*) AS sess FROM pg_stat_activity WHERE query <> '<IDLE>') AS activity
			WHERE
				stat_db.datname = '%s';
		  } % [@connection.db_name]

      puts res
      res
    end
  end
end
