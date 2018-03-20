lock '3.10.1'

# Change these
server '94.250.250.28', roles: [:web, :app, :db], primary: true

set :repo_url,        'https://github.com/PileOfTech/MidNightTown.git'
set :application,     'MNT'
set :user,            'root'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :log_level, :info

# Don't change these unless you know what you're doing
set :npm_flags, '--production'
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :nvm_map_bins, %w{node npm bower}
set :bundle_flags,    ""
set :assets_roles, [:web, :app]
set :assets_prefix, 'prepackaged-assets'
set :rails_assets_groups, :assets
set :normalize_asset_timestamps, %w{public/images public/javascripts public/stylesheets}
set :keep_assets, 2
set :migration_role, :app

#set :yarn_target_path, -> { release_path.join('subdir') }  # default not set
#set :yarn_flags, '--production --pure-lockfile --no-emoji --no-progress' # default
#set :yarn_roles, :all                                      # default
#set :yarn_env_variables, {}  

set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)
set :linked_files, %w(config/database.yml config/secrets.yml config/initializers/devise.rb)

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."

  task :config_symlink do
    run "cp #{shared_path}/../../shared/database.yml #{release_path}/config/database.yml"
  end

  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Run rake yarn:install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install")
      end
    end
  end

  desc 'Run rake npm install'
  task :npm_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && npm install")
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke! 'puma:restart'
    end
  end

  #before "deploy:assets:precompile", "deploy:yarn_install"
  #before "deploy:assets:precompile", "deploy:npm_install"
  before :starting,     :check_revision
  #after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart

end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
