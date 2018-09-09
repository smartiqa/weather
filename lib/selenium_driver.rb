require 'selenium-webdriver'
require 'forwardable'

class SeleniumDriver

  extend Forwardable

  def_delegators :@driver, :find_element, :find_elements

  DEFAULT_BROWSER = :chrome

  def initialize(host)
    @driver = Selenium::WebDriver.for DEFAULT_BROWSER
    @driver.manage.timeouts.implicit_wait = 30 # seconds
    @driver.navigate.to host
  end

  private

  def find_elem(id)
    @driver.find_element(id: id)
  end

  def selected?(id)
    find_elem(id).selected?
  end

  def click(id)
    elem = find_elem(id)
    elem.click
  end

end
