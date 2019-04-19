require 'rake'
require "bundler/gem_tasks"

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "shopify_api #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'open-uri'
def internet_connection?
  begin
    true if open("8.8.8.8")
  rescue
    false
  end
end

task :docker do
  cmd = "docker-compose up -d && docker exec -i -t shopify_api bash"
  begin
    system(cmd, err: File::NULL)
    raise RuntimeError.new("There is no internet connection") unless internet_connection?
  rescue => e
    puts e.inspect
  end
end
