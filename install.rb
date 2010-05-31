require 'fileutils'
require 'rubygems'

dir = File.dirname(__FILE__)
ext_all       = File.join('public', 'javascripts', 'ext-all.js')
ext_base      = File.join('public', 'javascripts', 'ext-base.js')
ext_jquery    = File.join('public', 'javascripts', 'ext-jquery-adapter.js')
ext_prototype = File.join('public', 'javascripts', 'ext-prototype-adapter.js')
ext_yui       = File.join('public', 'javascripts', 'ext-yui-adapter.js')

[ext_all, ext_base, ext_jquery, ext_prototype, ext_yui].each do |path|
  FileUtils.cp File.join(dir, path), File.join(dir, "/../../../" , path) unless File.exist?(File.join(dir, "/../../../", path))
end

puts IO.read(File.join(dir, 'README'))
