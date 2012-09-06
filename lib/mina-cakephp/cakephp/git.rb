namespace :cakephp do
  namespace :git do

    set :cake_revision, 'master'
    set :cake_repository, 'git://github.com/cakephp/cakephp.git'

    desc "Clone CakePHP Core."
    task :clone do
      queue %{
          echo "-----> Cloning CakePHP Core."
          #{echo_cmd %{git clone #{cake_repository} #{cake_path} -b #{cake_revision} --depth 1}} &&
          #{echo_cmd %{rm -Rf #{cake_path}/.git}} &&
          echo "-----> Done."
        }  
    end 
  end
end