Sidekiq.configure_server do |config|
  config.redis = { :url => "redis://#{Cartodb.config[:redis]['host']}:#{Cartodb.config[:redis]['port']}" }
end

# When in Unicorn, this block needs to go in unicorn's `after_fork` callback:
Sidekiq.configure_client do |config|
  config.redis = { :url => "redis://#{Cartodb.config[:redis]['host']}:#{Cartodb.config[:redis]['port']}" }
end
