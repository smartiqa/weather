require 'selenium/webdriver'
#require 'require_all'

Before do |scenario|
  $log.debug "###################### Scenario #{scenario.name} ######################"
end

at_exit do
  $common = nil
end

require_rel "./#{ENV['PROJECT'].downcase}_hooks.rb"
