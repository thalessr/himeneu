# if Rails.env.production?
#   $redis = Redis.new(:host => 'himeneu-001.8wfbqn.0001.usw2.cache.amazonaws.com', :port => 6379)
# else
#  $redis = Redis.new(:host => 'localhost', :port => 6379)
# end
$redis = Redis.new(:host => 'localhost', :port => 6379)
