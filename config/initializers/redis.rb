if !ENV["REDISTOGO_URL"].nil?
  puts "Using Redis To Go"
  $redis = Redis.new(:url => ENV['REDISTOGO_URL'])
else
  puts "Using local Redis"
  $redis = Redis.new(:host => Rails.application.config.redis_host, :port=> Rails.application.config.redis_port)
end
