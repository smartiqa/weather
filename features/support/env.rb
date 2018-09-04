$LOAD_PATH.unshift(File.dirname(__FILE__))

STDOUT.sync = true

require 'rspec/core'
require 'rspec/expectations'
# require 'active_support/all'
# require 'erb'
require 'logger'
require 'multilogger'
require 'require_all'

require_rel '../../lib'

results_path = File.join(Dir.pwd, 'results')
$project_results = File.join(results_path, ENV['PROJECT'])
log_filename = File.join(results_path, 'log.txt')
download_path = File.join(results_path, 'files')

if ENV['CLEAR_OPTS'] == 'log'
    File.delete(log_filename) if File.exist?(log_filename)
end

 if ENV['CLEAR_OPTS'] == 'all'
   FileUtils.rm_rf(results_path)
 end

Dir.mkdir(results_path) unless Dir.exist?(results_path)
Dir.mkdir($project_results) unless Dir.exist?($project_results)
Dir.mkdir(download_path) unless Dir.exist?(download_path)

 # remove RSpec "old syntax" deprecation warnings
 RSpec.configure do |config|
   config.expect_with :rspec do |c|
     c.syntax = [:should, :expect]
   end
 end

$log = MultiLogger.new(log_filename)
$log.info '================================= Starting tests ============================================'

# read data from config file
configs = []
env_dir = 'environment'
config_path = File.join(Dir.pwd, env_dir, ENV['CONFIG'])
esx_config = File.join(Dir.pwd, env_dir, 'esx.yaml')
configs << config_path if File.exist? config_path
configs << esx_config if File.exist? esx_config

begin
  $config = {}
  configs.each do |cf|
    $config.merge! YAML.load(ERB.new(File.read(cf)).result)
  end
  $config.each_pair { |key, value| $log.debug "#{key}=#{value}\n" } unless $config.nil?
rescue SystemCallError => e
  raise "Cannot find config file #{ENV['CONFIG']}" if e.message.include? 'No such file or directory'
end

 $config['LOGGER_LEVEL'] = 'DEBUG' unless $config.key?('LOGGER_LEVEL')
 case $config['LOGGER_LEVEL']
  when 'DEBUG'
    $log.level = Logger::DEBUG
  when 'INFO'
    $log.level = Logger::INFO
  when 'WARN'
    $log.level = Logger::WARN
  when 'ERROR'
    $log.level = Logger::Error
  when 'FATAL'
    $log.level = Logger::FATAL
  else
    $log.level = Logger::DEBUG
end

TEST_DATE = Time.now.strftime('%Y-%m-%d-%H-%M-%S')
LOG_PATH =  Dir.pwd + "/results/errors/#{TEST_DATE}"

require "#{ENV['PROJECT'].downcase}_env.rb"
require 'hooks.rb'

