# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application,     "evamama"
set :repo_url,        "git@github.com:LoicSka/EvaApi.git"
set :user,            "deployer"

set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :passenger_restart_with_touch, true
set :passenger_in_gemfile, true

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/system}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  Rake::Task['assets:precompile'].clear_actions
  Rake::Task['assets:backup_manifest'].clear_actions
  before 'deploy:migrate', :setup_environment
  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

desc 'Upload application.yml file to server'
task :setup_environment do
  on roles(:app) do
    upload! 'config/application.yml', release_path.join('config/application.yml').to_s
  end
end