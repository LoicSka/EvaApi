require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rails/migrations'
require 'capistrano/passenger'

# If you are using rvm add these lines:
require 'capistrano/rvm'
set :rvm_type, :user
set :rvm_ruby_version, '2.5.1p57'
# require 'capistrano/rbenv'
# set :rbenv_type, :user # or :system, depends on your rbenv setup
# set :rbenv_ruby, '2.5.1'

install_plugin Capistrano::SCM::Git

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
