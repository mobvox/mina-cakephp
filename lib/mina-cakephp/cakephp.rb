require 'mina-cakephp/cakephp/tmp'

namespace :cakephp do
  
  desc "Configure CakePHP Core include_path in webroot/index.php file."
  task :cake_core_path do
    regex = "((\\/\\/)?\\s*define\\('CAKE_CORE_INCLUDE_PATH',(.*)\\);)"

    queue %{
      echo "-----> Setting up CakePHP path." && (
        #{echo_cmd %{sed -ri "/#{regex}/ c define('CAKE_CORE_INCLUDE_PATH', '#{cake_core_path}');" webroot/index.php }} &&
        echo "------> Done."
      ) || (
        echo "! ERROR: Setup CakePHP path failed."
        echo "! Ensure that the path '#{deploy_to}' is accessible to the SSH user."
      )
    }
  end

  desc "Configure CakePHP database connection"
  task :config_database do
    config = cake_database.map{|i,v|
      "\t\t'#{i}' => '#{v}'"
    }.join(", \n")

    content = "<?php 
class DATABASE_CONFIG{
\tpublic \\$default = array(
#{config}
\t);
}"
  queue %{
    echo "-----> Creating CakePHP database config file." && (
      #{echo_cmd %{mkdir -p #{shared_path}/Config}} &&
      #{echo_cmd %{echo "#{content}" > #{shared_path}/Config/database.php}} &&
      echo "-----> Done."
    ) || (
      echo "ERROR: Problem to create database config file."
    )
  }
  end
end

# Adaptive tasks to setup CakePHP Application.
task :setup do
  invoke :'cakephp:tmp:create'
  invoke :'cakephp:config_database'
end