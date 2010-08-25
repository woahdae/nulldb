require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'activerecord-nulldb-adapter'
    gem.summary = %Q{The Null Object pattern as applied to ActiveRecord database adapters}
    gem.description = %Q{A database backend that translates database interactions into no-ops. Using NullDB enables you to test your model business logic - including after_save hooks - without ever touching a real database.}
    gem.email = "myron.marston@gmail.com"
    gem.homepage = "http://github.com/nulldb/nulldb"
    gem.authors = ["Avdi Grimm", "Myron Marston"]
    gem.rubyforge_project = "nulldb"

    gem.add_dependency 'activerecord', '>= 2.0.0'
    gem.add_development_dependency "rspec", ">= 1.2.9"

    gem.files.exclude 'vendor/ginger'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# rspec 2
require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/*_spec.rb"
end

task :spec => :check_dependencies if defined?(Jeweler)

desc 'Run ginger tests'
task :ginger do
  $LOAD_PATH << File.join(*%w[vendor ginger lib])
  ARGV.clear
  ARGV << 'spec'
  load File.join(*%w[vendor ginger bin ginger])
end

task :default => :ginger

require 'rake/rdoctask'
Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "LICENSE", "lib/**/*.rb")
end

desc "Publish project home page"
task :publish => ["rdoc"] do
  sh "scp -r html/* myronmarston@rubyforge.org:/var/www/gforge-projects/nulldb"
end
