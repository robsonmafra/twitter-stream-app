require "bundler/capistrano"

set :application, "TwiiterApp"
set :repository,  "git@github.com:robsonmafra/twitter-stream-app.git"
set :scm, :git 
set :deploy_via, :copy

ssh_options[:user] = "ubuntu"
ssh_options[:keys] = "/Users/robson/Development/chave-aws/aws-robson.pem"

server "app.robsonmafra.me", :app, :web, :db, :primary => true

set :deploy_to, "/storage/twitter_app"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -s USR2 `cat /storage/log/unicorn/nginx.pid`"
  end

  desc "Start unicorn"
  task :start do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop do
    run "kill -s QUIT `cat /storage/log/unicorn/nginx.pid`"
  end
end
