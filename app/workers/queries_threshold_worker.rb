class QueriesThresholdWorker
  include Sidekiq::Worker

  def perform(user_id, table_name, data_source, table_id = nil, append = false, migrate_table = nil, table_copy = nil, from_query = nil)
      CartoDB::QueriesThreshold.analyze(user_id, sql, time)
  end
end
