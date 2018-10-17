And /^Weather site is accessible$/ do
  raise "Weather site #{$site_manager.host} is unaccessible!" unless $site_manager.connection_is_available?
end

And /^I get basic city info for (.+) via API$/ do |city_name|
  $site_manager.process_basic_info(city_name)
end

And /^I check that (API|UI) weather data for (.+) is valid$/ do |source, city_name|
  raise "#{city_name} weather data is invalid!" unless $site_manager.city(city_name).weather_info_is_valid?(source.downcase.to_sym)
end

And /^I get current weather for (.+) via (API|UI)$/ do |city_name, source|
  $site_manager.process_weather_info(city_name, source.downcase.to_sym)
  a = 0
end

And /^API and UI weather info for (.+) matches$/ do |city_name|
  raise "API and UI #{city_name} weather data does't match!" unless $site_manager.weather_info_matches?(city_name)
  a = 0
end