module Elephant
  module Postgres
    module SizeQueries

      def top_sizes(limit = 20)
        exec %Q{
          SELECT
            relname AS name,
            relkind AS kind,
            pg_size_pretty(pg_relation_size(pg_class.oid)) AS size
          FROM
            pg_class
          ORDER BY
            pg_relation_size(pg_class.oid) DESC
          LIMIT #{limit}
        }
      end

      def size
        exec %Q{
          SELECT
            '#{@connection.db_name}' AS db_name,
            count(oid) AS num_rels,
            pg_size_pretty(pg_database_size('#{@connection.db_name}')) AS dbsize
          FROM
            pg_class
        }
      end
    end
  end
end
