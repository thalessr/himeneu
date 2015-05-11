# config valid only for current version of Capistrano


set :application, 'himeneu'
set :repo_url, 'git@github.com:thalessr/himeneu.git'
# set :rbenv_ruby, '2.1.5'
#set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
set :passenger_restart_with_sudo, false

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deployer/apps/himeneu'



# Default value for :scm is :git
set :scm, :git
set :user, "deployer"
set :deploy_via, :remote_cache

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')
# set :linked_files, %w{config/database.yml config/secrets.yml .env}

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

set :default_env, {
  S3_BUCKET: "himeneusp",
  AWS_SECRET_ACCESS_KEY: "p+cOTO8/KiobSMtDI/7p0OxR5YyFMAav/IOsrcKS",
  AWS_ACCESS_KEY_ID: "AKIAIFQFVIS34VVFGNWQ",
  RDS_HOST: "himeneu.cilct9pmpdx5.us-west-2.rds.amazonaws.com",
  RDS_DB: "himeneu_production",
  RDS_USERNAME: "himeneu_admin",
  RDS_PASSWORD: "kill_klb",
  REGION: "sa-east-1",
  MANDRILL_USER_NAME: "thalessr@gmail.com",
  MANDRILL_PASSWORD: "_xRMsiT0NHt675Wa9PcYiw",
  MANDRILL_ADDRESS: "smtp.mandrillapp.com",
  ASSET: "d3fdbsfz8d5x1m.cloudfront.net",
  DEPLOYER_PASSWORD: "tr3ta"
}


namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #  execute :rake, 'cache:clear'
      # end
    end
  end

end

after "deploy", "deploy:migrate"
after :deploy, "deploy:sitemap:refresh"
after "deploy:updated", "newrelic:notice_deployment"

namespace :sidekiq do
  task :start do
    run "cd #{current_path} && bundle exec sidekiq -q mailer, -q default, -q carrierwave -c 10 -e production -L log/sidekiq.log -d"
    p capture("ps aux | grep sidekiq | awk '{print $2}' | sed -n 1p").strip!
  end
end
