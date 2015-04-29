if Rails.env.production?
  $redis = Redis.new(:host => '104.236.232.221', :port => 6379)
else
 $redis = Redis.new(:host => 'localhost', :port => 6379)
end
# $redis = Redis.new(:host => 'localhost', :port => 6379)
