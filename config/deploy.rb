# config valid only for current version of Capistrano
lock '3.3.3'

set :application, 'move-me'

set :scm, :git
set :repo_url, 'git@github.com:asavale1/move-me.git'

set :user, "ameya"


#set :stages, ["production"]
set :default_stage, 'production'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/www/sites/move-me'

after "deploy", "deploy:restart"
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :rails_env, "production"

set(:linked_files, %w(config/database.yml))
# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  	after :restart, :clear_cache do
    	on roles(:web), in: :groups, limit: 3, wait: 10 do
      	# Here we can do anything such as:
      	# within release_path do
      	#   execute :rake, 'cache:clear'
      	# end
      		#run "touch #{current_path}/tmp/restart.txt"
    	end
  	end

  	desc "Restart Passenger app"
	task :restart do
    	execute :touch "#{ File.join(current_path, 'tmp', 'restart.txt') }"
	end

end
