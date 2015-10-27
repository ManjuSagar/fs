rvm = true

if rvm
  # RVM Start

  # Add RVM's lib directory to the load path.
  #RVM 1.12.1 doesn't work with following line. Comment as per google to resolve.
  #$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

  # Load RVM's capistrano plugin.    
  require "rvm/capistrano"

  set :rvm_ruby_string, '2.1.5'
  set :rvm_type, :user  # Don't use system-wide RVM

  # RVM End
end

require 'bundler/capistrano'

set :use_sudo, false
set :user, 'ubuntu'
#if ENV['ENV'] == 'production'
 # set :domain, 'apps.fasternotes.net'
#else
  set :domain, 'draft.fasternotes.net'
#end

set :branch, ENV['BRANCH'] || 'master'

set :applicationdir, "/home/ubuntu/workspace/fasternotes"

set :application, "set your application name here"
#set :repository,  "set your repository location here"

#set :scm, :git
#set :repository,  "git@github.com:h2hDevelopment/bownce_server.git"

#set :scm, :subversion
#set :repository, "svn://msserver/custom_rails_projects/fasternotes/trunk"
set :scm, "git"
user = ENV['GIT_USER'] || "mahaswami"
password = ENV['PASSWORD'] 
set :repository, "https://praveen-ms:praveen-ms1234@github.com/Mahaswami/fasternotes.git"  # Your clone URL
#if ENV['ENV'] == 'production'
#  set :branch, "production"
#else
  set :branch, "wamika_doc_performance_test"
#end
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain
role :app, domain
role :db,  domain, :primary => true # This is where Rails migrations will run

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :remote_cache

default_run_options[:pty] = true  # Forgo errors when deploying from windows

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
#if ENV['ENV'] == 'production'
 # ssh_options[:keys] = %w(~/workspace/cloud/fasternotes_production.pem)            # If you are using ssh_keysset :chmod755, "app config db lib public vendor script script/* public/disp*"set :use_sudo, false
#else
  ssh_options[:keys] = %w(~/workspace/cloud/fasternotes.pem)            # If you are using ssh_keysset :chmod755, "app config db lib public vendor script script/* public/disp*"set :use_sudo, false
#end
# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
 	desc "Symlink shared configs and folders on each release."
  task :symlink_shared_images do
    run "ln -nfs #{shared_path}/static_content #{release_path}/public"
  end
  
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end

 task :precompile do
   run "bundle exec rake assets:precompile"
 end
end

namespace :rvm do
  desc 'Trust rvmrc file'
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end
end

after "deploy:update_code", "rvm:trust_rvmrc"#, "deploy:precompile"
#after 'deploy:create_symlink', 'deploy:symlink_shared_images'