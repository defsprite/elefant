module Elephant
  module Postgres
    module SizeQueries

      def top_sizes(limit = 20)
        %Q{
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

      def size(database = @connection.db_name)
        %Q{
          SELECT
            '#{database}' AS db_name,
            count(oid) AS num_relations,
            pg_size_pretty(pg_database_size('#{database}')) AS dbsize
          FROM
            pg_class
        }
      end
    end
  end
end

