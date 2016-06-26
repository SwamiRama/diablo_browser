require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/nginx'
require 'mina/scp'

require 'figaro'
Figaro.application = Figaro::Application.new(environment: "deployment", path: "#{File.join(Dir.pwd, 'config', 'application.yml')}")
Figaro.load

set :application, ENV['application']
set :domain, ENV['domain']
set :deploy_to, ENV['deploy_to']
set :repository, ENV['repository']
set :branch, ENV['branch']

set :user, ENV['deploy_user']
set :port, ENV['port']
set :forward_agent, true

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
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
    scp_upload 'config/application.yml', "#{deploy_to}/shared/config/application.yml", verbose: true
  end
  deploy do

    in_directory "#{deploy_to}/current" do
      queue "docker-compose down"
    end

    in_directory "#{deploy_to}" do
      queue 'rm -rf current'
      queue 'mkdir current'
    end

    in_directory "#{deploy_to}/current" do
      invoke :'git:clone'
      queue "cp #{deploy_to}/shared/config/application.yml #{deploy_to}/current/config/application.yml"
      queue "docker-compose build"
      queue "echo ..."
      queue "echo ..."
      queue "docker-compose run -e RAILS_ENV=production app rake db:migrate"
      queue "mkdir -p tmp/sockets"
      queue "mkdir -p tmp/pids"
      # queue "docker-compose run -e RIALS_ENV=production app rake assets:precompile"
    end
    to :launch do
      queue "docker-compose run -e RAILS_ENV=production -d app puma -e production -C config/puma.rb -b unix:///app/tmp/sockets/puma.sock"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"

    end
  end
end
