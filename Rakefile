#!/usr/bin/env ruby
require 'redmine_plugin_support'

Dir[File.expand_path(File.dirname(__FILE__)) + "/lib/tasks/**/*.rake"].sort.each { |ext| load ext }

RedminePluginSupport::Base.setup do |plugin|
  plugin.project_name = 'chiliproject_knowledgebase'
  plugin.default_task = [:test]
  plugin.tasks = [:db, :doc, :release, :clean, :test, :stats, :metrics]
  # TODO: gem not getting this automaticly
  plugin.redmine_root = File.expand_path(File.dirname(__FILE__) + '/../../../')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "chiliproject_knowledgebase"
    s.summary = "An easy way to capture knowledge you are already creating in ChiliProject/Redmine and make it easier to discover and share."
    s.email = "edavis@littlestreamsoftware.com"
    s.homepage = "https://projects.littlestreamsoftware.com/projects/chiliproject_knowledgebase"
    s.description = "An easy way to capture knowledge you are already creating in ChiliProject/Redmine and make it easier to discover and share."
    s.authors = ["Eric Davis"]
    s.rubyforge_project = "TODO" # TODO
    s.files =  FileList[
                        "[A-Z]*",
                        "init.rb",
                        "rails/init.rb",
                        "{bin,generators,lib,test,app,assets,config,lang}/**/*",
                        'lib/jeweler/templates/.gitignore'
                       ]
  end
  Jeweler::GemcutterTasks.new
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
