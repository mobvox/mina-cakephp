# mina-cakephp

mina-cakephp is a gem that adds many tasks to aid in the deployment of [CakePHP] (http://www.cakephp.org) applications
using [Mina] (http://nadarei.co/mina).

# Getting Start

## Instalation
	
	gem install mina-cakephp

## Configuration

After installation, create a file in the root directory of your project called `Minafile`.

Note: Mina uses the command `mina init` to create a config file at `config/deploy.rb`, but CakePHP use the `Config` directory to hold configurations.
To avoid problems we recommend using `Minafile` instead of `config/deploy.rb`

`Minafile` sample:

	require 'mina/git'
	# Load tasks of mina-cakephp
	require 'mina-cakephp'

	# Mina default configuration
	# more info at http://nadarei.co/mina
	set :domain, 'server.to.deploy.com' 
	set :deploy_to, '/var/www/my-app'
	set :repository, 'git@mysever:my-app.git'
	set :user, 'root'

	# Shared file or folder between deploys
	# more at http://nadarei.co/mina/tasks/deploy_link_shared_paths.html
	set :shared_paths, ['Config/database.php', 'tmp']

	## mina-cakephp Settings
	# Defines the  CakePHP core path. 
	# This path is used to execute bake commands and update webroot/index.php if needed.
	set :cake_path, '/var/www/libs/cakephp'
	# Database connection settings.
	# This will be used to create Config/database.php
	set :cake_database, {
		'datasource' => 'Database/Mysql',
		'persistent' => false,
		'host' => 'localhost',
		'login' => 'user',
		'password' => 'my-password',
		'database' => 'my-db',
		'prefix' => ''
	}

	## Deploy Task
	task :deploy do
	  deploy do
	  	# Clone project, more at http://nadarei.co/mina/tasks/git_clone.html
	    invoke :'git:clone'
	    # Create symlinks
	    # more at http://nadarei.co/mina/tasks/deploy_link_shared_paths.html
	    invoke :'deploy:link_shared_paths'
	    
	    # If you do not have CakePHP in your include_path, you will need to set CakePHP core path at webroot/index.php.
	    # This task will do it for you.
	    invoke :'cakephp:cake_core_path'
	    # This task changes the debug level to 0 at Config/core.php
	    invoke :'cakephp:debug_disable'
	    # This task will delete all temporary files at tmp/
	    invoke :'cakephp:tmp:clean_cache'

	    # This task will create a folder and set correct permissions 
	    # to receive build files of AssetCompress plugin (https://github.com/markstory/asset_compress)
	    invoke :'cakephp:asset_compress:setup'
	    # Build asset files
	    invoke :'cakephp:asset_compress:build'

	    to :launch do
	    	# If you are using the Migrations plugin of CakeDC
	    	# you need to invoke this task to run all migrations before launching the application.
	    	invoke :'cakephp:migrations:run_all'
	    end
	  end
	end

	# Taks to prepare the environment
	task :setup do
	    # Invoke this task if you need to clone CakePHP core when setting up the enviroment.
	    invoke :'cakephp:git:clone'
	end

## Setup Environment

	mina setup

More at http://nadarei.co/mina/directory_structure.html

## Deploying

	mina deploy

More at http://nadarei.co/mina/deploying.html

## More tasks

Run

	mina -T

To list all tasks.

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