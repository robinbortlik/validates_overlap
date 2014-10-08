require 'rubygems'
require 'bundler'
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'rdoc/task'

begin
  Bundler::GemHelper.install_tasks
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "validates_overlap #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
