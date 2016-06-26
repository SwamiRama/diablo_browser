require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/puma'
require 'mina/nginx'
require 'mina/rbenv'
require 'mina/scp'

require 'figaro'
Figaro.application = Figaro::Application.new(environment: "deployment", path: "#{File.join(Dir.pwd, 'config', 'application.yml')}")
Figaro.load

set :application, ENV['application']
set :domain, ENV['domain']
set :deploy_to, ENV['deploy_to']
set :repository, ENV['repository']
set :branch, ENV['branch']

## Puma setup
set :puma_socket, "#{deploy_to}/#{shared_path}/tmp/sockets/puma.sock"
set :pumactl_socket, "#{deploy_to}/#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_pid, "#{deploy_to}/#{shared_path}/tmp/pids/puma.pid"
set :puma_state, "#{deploy_to}/#{shared_path}/tmp/pids/puma.state"

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/application.yml', 'log', 'tmp/sockets', 'tmp/pids']

set :user, ENV['deploy_user']
set :port, ENV['port']
set :forward_agent, true

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rbenv:load'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/sockets"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]

  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/application.yml'."]

  scp_upload('config/nginx.conf', "#{deploy_to}/#{shared_path}/config/nginx.conf")
  invoke :'nginx:link'
  invoke :'nginx:restart'

  if repository
    repo_host = repository.split(%r{@|://}).last.split(%r{:|\/}).first
    repo_port = /:([0-9]+)/.match(repository) && /:([0-9]+)/.match(repository)[1] || '22'

    queue %[
      if ! ssh-keygen -H  -F #{repo_host} &>/dev/null; then
        ssh-keyscan -t rsa -p #{repo_port} -H #{repo_host} >> ~/.ssh/known_hosts
      fi
    ]
  end
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    scp_upload('config/application.yml', "#{deploy_to}/#{shared_path}/config/application.yml")
    scp_upload('config/application.yml', "#{deploy_to}/#{shared_path}/config/application.yml")

    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
      invoke :'puma:start'
      invoke :'puma:phased_restart'
    end
  end
end
