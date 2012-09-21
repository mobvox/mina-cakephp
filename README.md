# mina-cakephp

mina-cakephp add supports to deploy CakePHP Applications using [Mina](http://nadarei.co/mina).

## How to use

Create one file at root directory of app named Minafile. Sample:

	require 'mina/git'
	require 'mina-cakephp'

	set :domain, 'server.to.deploy.com' 
	set :deploy_to, '/var/www/my-app'
	set :repository, 'git@mysever:my-app.git'
	set :user, 'root'

	set :shared_paths, ['Config/database.php', 'tmp'] #CakePHP shared paths used at apps.

	#CakePHP Config
	set :cake_path, '/var/www/libs/cakephp' #CakePHP core path
	set :cake_database, { #Connection configuration
		'datasource' => 'Database/Mysql',
		'persistent' => false,
		'host' => 'localhost',
		'login' => 'user',
		'password' => 'my-password',
		'database' => 'my-db',
		'prefix' => ''
	}

	#Steps to deploy app

	task :deploy do
	  deploy do
	    invoke :'git:clone' #Clone project from :respository
	    invoke :'deploy:link_shared_paths' #Create symlinks of :shared_paths
	    
	    invoke :'cakephp:cake_core_path' #Set CakePHP Core path at webroot/index.php
	    invoke :'cakephp:debug_zero' #Set debug 0 at Config/core.php
	    invoke :'cakephp:tmp:clean_cache' #Clear tmp files

	    invoke :'cakephp:asset_compress:setup' #Create folder to receive assets
	    invoke :'cakephp:asset_compress:build' #Run Schema build command line

	    to :launch do
	      invoke :'cakephp:migrations:run_all' #Run migrations before launch app
	    end
	  end
	end

	desc "Custom setup commands"
	task :setup do
	    #Clone CakePHP Core into cake_path, you can omit this if you dont need to clone cakephp when 
	    #run mina setup
	    #invoke :'cakephp:git:clone'
	end

Then run:
	
	mina setup

It will prepare server to receive first deploy.

To deploy your app just run:

	mina deploy

Done.

## Contributing to mina-cakephp
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 MobVox Soluções Digitais http://www.mobvox.com.br
See LICENSE for further details.