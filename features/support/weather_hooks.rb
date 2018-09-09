After('@skip_if_failed') do |scenario|
  Cucumber.wants_to_quit = true if scenario.failed?
end
