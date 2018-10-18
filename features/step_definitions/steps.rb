And /^Weather site is accessible$/ do
  raise "Weather site #{$site_manager.host} is unaccessible!" unless $site_manager.connection_is_available?
end

And /^basic city info for (.+) retrieved via API$/ do |city_name|
  $site_manager.process_basic_info(city_name)
end

And /^current weather info for (.+) is collected via (API|UI)$/ do |city_name, source|
  $site_manager.process_weather_info(city_name, source.downcase.to_sym)
end

And /^(API|UI) weather data validation for (.+) is successful$/ do |source, city_name|
  raise "#{city_name} weather data is invalid!" unless $site_manager.city(city_name).weather_info_is_valid?(source.downcase.to_sym)
end

And /^API and UI weather info for (.+) matches$/ do |city_name|
  raise "API and UI #{city_name} weather data does't match!" unless $site_manager.weather_info_matches?(city_name)
end