And /^Weather site is accessible$/ do
  raise "Weather site #{$site_manager.host} is unaccessible!" unless $site_manager.connection_is_available?
end

And /^I get basic city info for (.+) via API$/ do |city_name|
  $site_manager.process_basic_info(city_name)
end

And /^I get current weather for (.+) via API$/ do |city_name|
  $site_manager.process_weather_info(city_name)
end

And /^I check that weather data for (.+) is valid$/ do |city_name|
  raise "#{city_name} weather data is invalid!" unless $site_manager.city(city_name).weather_info_is_valid?
end

And /^I get current weather for (.+) via UI$/ do |city_name|
# TODO: implement step functionality
end