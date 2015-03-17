module CacheRedis

  module Utils
    def set_redis_key(key, value, time = 1)
      $redis.set(key, value)
      $redis.expire(key, time.hour.to_i)
    end

    def get_redis_value(key)
      JSON.load  $redis.get(key)
    end

    def self.del_key(key)
      $redis.del(key)
    end
  end

end