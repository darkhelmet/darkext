require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = 'darkext'
    s.summary = %q{Just some useful Ruby functionality}
    s.email = 'darkhelmet@darkhelmetlive.com'
    s.homepage = 'http://github.com/darkhelmet/darkext'
    s.description = %q{Just some useful Ruby functionality. No particular focus, except usefulness}
    s.authors = ['Daniel Huckstep']
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'foo'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end
rescue LoadError
  puts 'RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov'
end

begin
  require 'spec/rake/spectask'
  Spec::Rake::SpecTask.new do |t|
    t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
  end
rescue LoadError
  puts 'rspec is not available. In order to run rspec, you must: sudo gem install rspec'
end

task :default => :spec
