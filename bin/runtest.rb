#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'
require 'find'
require 'trollop'
require 'yaml'
require 'fileutils'

$opts = Trollop.options do
  version 'Version: Runtest 1.0'
  opt :project, 'Project name', type: String, required: true, short: 'r'
  opt :browser, 'Select the browser, can be firefox, chrome', default: 'firefox', type: String
  opt :driver, 'Select WebDriver, can be selenium, poltergeist', default: 'selenium', type: String
  opt :testpath, 'The path to tested features (the name of the sub-project)', type: String, required: true, short: 'p'
  opt :junit, 'Generates a report similar to Ant+JUnit.', default: false, short: 'j'
  opt :pretty, 'Prints the feature as is - in colours.', default: true, short: 'n'
  opt :html, 'Generates a nice looking HTML report.', default: false, short: 'h'
  opt :json, 'Generates a JSON report.'
  opt :expand, 'Expand Scenario Outline Tables in output', default: false, short: 'e'
  opt :tags, '', default: ['~@skip'], short: 't'
  opt :config, 'Choose yaml config file', type: String, short: 'c'
  opt :testid, 'Unique part of your indentifiers', type: String
  opt :profile, 'Cucumber profile name', type: String
  banner <<-EOS

Example:

   runtest.rb -r TestLab -p Smoke --profile TESTLAB --html --junit --json --testid TL --config axsml.yaml --tags ~@full ~@skip

  EOS
end

current_file_dir = Dir.pwd

Dir.chdir(File.dirname(__FILE__) + "/../features/#{$opts[:project]}/#{$opts[:testpath]}")
current_dir = Dir.pwd

$opts[:profile] ||= $opts[:project]

# Form a cmd with parameters to run Cucumber
# We should go to a project's root directory to let Cucumber do its job
cl = "cd #{current_file_dir}/.. && bundle exec cucumber --no-source"

arr = $opts[:testpath].split(/\//)

result_dir = current_file_dir + "/../results/#{$opts[:project]}"
report_name = result_dir + "/#{arr[-1]}_report.html"
report_json = result_dir + "/#{arr[-1]}_report.json"
report_junit = result_dir + "/#{arr[-1]}"
FileUtils.mkdir_p result_dir unless File.exist?(result_dir)

cl = cl + ' ' + "\"#{current_dir}\""
# We use profile from cucumber.yml file to specify for Cucumber what to load
cl += " --profile #{$opts[:profile]}"
cl += ' --color'
cl += ' --expand' if $opts[:expand]
cl += ' --format pretty' if $opts[:pretty]
cl += " PROJECT=#{$opts[:project]}"
cl += " BROWSER=#{$opts[:browser]}"
cl += " WEBDRIVER=#{$opts[:driver]}"
cl += " TS=#{$opts[:testpath]}"
cl += " CONFIG=#{$opts[:config]}" if $opts[:config]
cl += " TEST_ID=#{$opts[:testid]}" if $opts[:testid]
cl += " --format junit --out \"#{report_junit}\"" if $opts[:junit]
cl += " --format html --out \"#{report_name}\"" if $opts[:html]
cl += " --format json --out \"#{report_json}\"" if $opts[:json]

$opts[:tags].each { |index| cl += " --tags #{index}" }

puts "CL = #{cl}"

system(cl)
