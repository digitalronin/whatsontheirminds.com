set :application, "parlour-tag"
set :repository,  "git@github.com:digitalronin/parlour-tag.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :git_enable_submodules, 1

depend :remote, "#{deploy_to}/shared/system/keys.rb"

role :app, "rewiredstate"
role :web, "rewiredstate"
role :db, "rewiredstate", :primary => true

