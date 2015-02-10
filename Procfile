web: bundle exec passenger start -p $PORT
worker: bundle exec sidekiq -q mailer, -q default, -q carrierwave -c 10 -e production -L log/sidekiq.log -d