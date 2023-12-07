require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  task :spec
end

task default: :spec
