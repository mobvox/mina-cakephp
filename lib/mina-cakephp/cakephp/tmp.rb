namespace :cakephp do
  namespace :tmp do

    set :cake_tmp_dirs, ['cache','cache/models','cache/persistent','cache/views','sessions','logs','tests']

    desc "Setup CakePHP tmp directories."
    task :create do
      cmds = cake_tmp_dirs.map do |d|
        echo_cmd %{mkdir -p #{shared_path}/tmp/#{d}}
      end

      queue %{
          echo "-----> Setting up CakePHP tmp directories"
          #{cmds.flatten.join("\n")}
          #{echo_cmd %{chmod -R 777 #{shared_path}/tmp}}
          echo "-----> Done CakePHP"
        }  
    end

    desc "Clean caches files"
    task :clean_cache do
      cmds = cake_tmp_dirs.map do |d|
        echo_cmd %{rm -f #{shared_path}/tmp/#{d}/*} if d =~ /cache/
      end

      queue %{
          echo "-----> Cleaning CakePHP cache directories"
          #{cmds.flatten.join("\n")}
          echo "-----> Done."
        }  
    end
  end
end