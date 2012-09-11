require 'mina-cakephp/helpers'

namespace :cakephp do
  namespace :schema do
    extend MinaCakePHP

    desc "Use schema.php to create database schema"
    task :create do
      cake_cmd "schema create --name #{cake_schema_name}"
    end

    desc "Run CakePHP schema update"
    task :update do
      cake_cmd "schema update --name #{cake_schema_name}"
    end
  end
end