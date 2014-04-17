require 'test_helper'
require 'shopify_api/cli'
require 'fileutils'

class CliTest < Test::Unit::TestCase
  def setup
    @test_home = File.join(File.expand_path(File.dirname(__FILE__)), 'files', 'home')
    @shop_config_dir = File.join(@test_home, '.shopify', 'shops')
    @default_symlink = File.join(@shop_config_dir, 'default')
    `rm -rf #{@test_home}`
    ENV['HOME'] = @test_home
    @cli = ShopifyAPI::Cli.new

    FileUtils.mkdir_p(@shop_config_dir)
    File.open(config_file('foo'), 'w') do |file|
      file.puts valid_options.merge('domain' => 'foo.myshopify.com').to_yaml
    end
    File.symlink(config_file('foo'), @default_symlink)
    File.open(config_file('bar'), 'w') do |file|
      file.puts valid_options.merge('domain' => 'bar.myshopify.com').to_yaml
    end
  end

  def teardown
    `rm -rf #{@test_home}`
  end

  test "add with blank domain" do
    `rm -rf #{@shop_config_dir}/*`
    $stdout.expects(:print).with("Domain? (leave blank for foo.myshopify.com) ")
    $stdout.expects(:print).with("API key? ")
    $stdout.expects(:print).with("Password? ")
    $stdin.expects(:gets).times(3).returns("", "key", "pass")
    @cli.expects(:puts).with("\nopen https://foo.myshopify.com/admin/api in your browser to get API credentials\n")
    @cli.expects(:puts).with("Default connection is foo")

    @cli.add('foo')

    config = YAML.load(File.read(config_file('foo')))
    assert_equal 'foo.myshopify.com', config['domain']
    assert_equal 'key', config['api_key']
    assert_equal 'pass', config['password']
    assert_equal 'https', config['protocol']
    assert_equal config_file('foo'), File.readlink(@default_symlink)
  end

  test "add with explicit domain" do
    `rm -rf #{@shop_config_dir}/*`
    $stdout.expects(:print).with("Domain? (leave blank for foo.myshopify.com) ")
    $stdout.expects(:print).with("API key? ")
    $stdout.expects(:print).with("Password? ")
    $stdin.expects(:gets).times(3).returns("bar.myshopify.com", "key", "pass")
    @cli.expects(:puts).with("\nopen https://bar.myshopify.com/admin/api in your browser to get API credentials\n")
    @cli.expects(:puts).with("Default connection is foo")

    @cli.add('foo')

    config = YAML.load(File.read(config_file('foo')))
    assert_equal 'bar.myshopify.com', config['domain']
  end

  test "list" do
    @cli.expects(:puts).with("   bar")
    @cli.expects(:puts).with(" * foo")

    @cli.list
  end

  test "show default" do
    @cli.expects(:puts).with("Default connection is foo")

    @cli.default
  end

  test "set default" do
    @cli.expects(:puts).with("Default connection is bar")

    @cli.default('bar')

    assert_equal config_file('bar'), File.readlink(@default_symlink)
  end

  test "remove default connection" do
    @cli.remove('foo')

    assert !File.exist?(@default_symlink)
    assert !File.exist?(config_file('foo'))
    assert File.exist?(config_file('bar'))
  end

  test "remove non-default connection" do
    @cli.remove('bar')

    assert_equal config_file('foo'), File.readlink(@default_symlink)
    assert File.exist?(config_file('foo'))
    assert !File.exist?(config_file('bar'))
  end

  private

  def valid_options
    {'domain' => 'snowdevil.myshopify.com', 'api_key' => 'key', 'password' => 'pass', 'protocol' => 'https'}
  end

  def config_file(connection)
    File.join(@shop_config_dir, "#{connection}.yml")
  end

end
