$LOAD_PATH.unshift(File.dirname(__FILE__))
STDOUT.sync = true
require 'require_all'
require_rel '../../lib'

puts '------------------------------- Starting tests -------------------------------'

# read data from config file
config_path = File.join(Dir.pwd, 'environment', ENV['CONFIG'])
begin
  $config = YAML.load(ERB.new(File.read(config_path)).result)
rescue SystemCallError => e
  raise "Can't find config file #{ENV['CONFIG']}" if e.message.include? 'No such file or directory'
end

$site_manager = SiteManager.new($config['site'], $config['site_api'])

require 'hooks.rb'

