$redis = Redis.new(:host => Rails.application.config.redis_host, :port=> Rails.application.config.redis_port)
