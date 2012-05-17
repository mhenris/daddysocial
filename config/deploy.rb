require "bundler/capistrano"
load "deploy/assets"

default_environment['PKG_CONFIG_PATH'] = "/usr/local/lib/pkgconfig"

set :application, "daddysocial.com"
set :repository,  "git@morgan.github.com:mhenris/daddysocial.git"
set :branch, "develop"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, 'dsdeploy'
set :use_sudo, false
set :deploy_to, "/var/www/daddysocial"
set :deploy_via, :remote_cache

role :web, "daddysocial.com"
role :app, "daddysocial.com"
role :db,  "daddysocial.com", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# Migrate the DB
after 'deploy', 'deploy:migrate'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
