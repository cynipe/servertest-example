require 'rake'
require 'rspec/core/rake_task'
require 'pathname'

nodes = Pathname.new('spec/system').children.reduce([]) {|mem, file| mem << file.basename.to_s if file.directory?; mem }

namespace :spec do

  desc 'Run spec for all nodes'
  task :all => nodes.map {|node| 'spec:' + node }

  nodes.each do |node|
    desc "Run spec for #{node}"
    RSpec::Core::RakeTask.new(node.to_sym) do |t|
      ENV['TARGET_VM'] = node
      t.pattern = "spec/system/#{node}/*_spec.rb"
    end
  end
end

