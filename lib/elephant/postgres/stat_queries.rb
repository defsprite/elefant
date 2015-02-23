module Elephant::Postgres
  module StatQueries

    def initialize(connection)
      @connection = connection
    end

    def activity
      exec %Q{
          SELECT
            -- datid
            -- datname
            -- pid
            -- usesysid
            usename          AS act_user,
            application_name AS act_app,
            client_addr      AS act_c_addr,
            client_hostname  AS act_c_host,
            client_port      AS act_c_port,
            backend_start    AS act_bknd_start,
            xact_start       AS act_tx_start,
            query_start      AS act_q_start,
            state_change     AS act_st_chng,
            waiting          AS act_wtng,
            state            AS act_state,
            query            AS act_qry
          FROM
            pg_stat_activity
          WHERE
            datname = '%s';
      } % [@connection.db_name]
    end

    def user_tables
      exec %Q{
        SELECT
          relname        AS rel_name,
          heap_blks_read AS heap_blks_rd,
          heap_blks_hit  AS heap_blks_ht,
          idx_blks_read  AS idx_blks_rd,
          idx_blks_hit   AS idx_blks_ht
        FROM
          pg_statio_user_tables;
      }
    end

    def user_indexes
      exec %Q{
        SELECT
          -- relid
          -- indexrelid
          -- schemaname
          relname AS rel_name,
          indexrelname AS idx_name,
          idx_scan AS idx_scn,
          idx_tup_read AS idx_tup_rd,
          idx_tup_fetch  AS idx_tup_ftch
        FROM
          pg_stat_user_indexes;
      }
    end

    def summary
      exec %Q{
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
    end
  end
end
