require 'selenium-webdriver'

@driver = Selenium::WebDriver.for :chrome
@driver.manage.timeouts.implicit_wait = 60 # seconds
@driver.navigate.to 'https://www.google.com'

search_input = @driver.find_element(xpath: '//*[@name="q"]')
search_input.send_keys 'weather moscow'
search_btn = @driver.find_element(css: 'div[class="FPdoLc VlcLAe"]>center>input[name="btnK"]')
search_btn.click

puts 'Weather info found!'