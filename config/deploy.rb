# config valid only for current version of Capistrano
lock '3.3.3'

set :application, 'didi'
set :repo_url, 'git@coding.net:songlipeng2003/didi.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rvm_type, :auto                     # Defaults to: :auto
set :rvm_ruby_version, 'default'      # Defaults to: 'default'
# set :rvm_custom_path, '~/.myveryownrvm'  # only needed if not detected

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# set :nvm_type, :user # or :system, depends on your nvm setup
# set :nvm_node, 'v0.10.36'
# set :nvm_map_bins, %w{node npm bower}
# set :npm_roles, :web

namespace :deploy do
  after :publishing, :restart

  # task :bower_install do
  #   on roles(:web) do
  #     within release_path do
  #       execute :rake, 'bower:install'
  #     end
  #   end
  # end

  # before 'deploy:compile_assets', 'deploy:bower_install'
end
