require 'rake'
require "bundler/gem_tasks"
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.warning = false
end

RuboCop::RakeTask.new

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task(:rcov) do
    abort("RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov")
  end
end

task default: [:test, :rubocop, :verify_docs]

require 'verify_docs'
task :verify_docs do
  unless VerifyDocs.call
    abort("\nWARNING: docs/index.md and README.md no longer have identical content. Please correct this.")
  end
end

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

task :docker do
  cmd = "docker-compose up -d && docker exec -i -t shopify_api bash"
  exec(cmd, err: File::NULL)
end
