set :application, "parlour-tag"
set :repository,  "git@github.com:digitalronin/parlour-tag.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :branch, "deploy"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :git_enable_submodules, 1

set :ssh_options, { :forward_agent => true, :compression => false }
set :user, 'appuser'

role :app, "rewiredstate"
role :web, "rewiredstate"
role :db, "rewiredstate", :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Copy required files from shared dirs"
  task :copy_shared, :roles => :app do
    run "cp #{shared_path}/system/keys.rb #{current_path}/lib/"
  end
end

after 'deploy:symlink', 'deploy:copy_shared'
