%w{ models controllers helpers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

ActionView::Base.send(:include, RorextHelper)

# install files
unless File.exists?(RAILS_ROOT + '/public/javascripts/rorext.js')
  ['/public', '/public/javascripts'].each do |dir|
    source = File.dirname(__FILE__) + "/../#{dir}"
    dest = RAILS_ROOT + dir
    FileUtils.mkdir_p(dest)
    FileUtils.cp(Dir.glob(source+'/*.*'), dest)
  end
end