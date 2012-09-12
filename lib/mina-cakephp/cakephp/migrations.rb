require 'mina-cakephp/helpers'

namespace :cakephp do
  namespace :migrations do
    extend MinaCakePHP

    desc "Use schema.php to create database schema"
    task :run_all do
      cake_cmd "Migrations.migration run all"
    end
    
  end
end