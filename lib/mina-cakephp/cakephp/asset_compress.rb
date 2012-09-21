require 'mina-cakephp/helpers'
namespace :cakephp do
  namespace :asset_compress do
    extend MinaCakePHP

    set :asset_path, 'assets'

    desc "Create asset directory based on asset_path config."
    task :setup do
      queue %{
          echo "-----> Setup assets directory."
          #{echo_cmd %{mkdir -p webroot/#{asset_path}}} &&
          #{echo_cmd %{chmod -R 755 webroot/#{asset_path}}} &&
          echo "-----> Done."
        }
    end

    desc "Clears all builds defined in the ini file."
    task :clear do
      cake_cmd "AssetCompress.AssetCompress clear"
    end

    desc "Generate all builds defined in the ini and view files."
    task :build do
      cake_cmd "AssetCompress.AssetCompress build"
    end

    desc "Generate only build files defined in the ini file."
    task :build_ini do
      cake_cmd "AssetCompress.AssetCompress build_ini"
    end

    desc "Build build files defined in view files."
    task :build_dynamic do
      cake_cmd "AssetCompress.AssetCompress build_dynamic"
    end
  end
end