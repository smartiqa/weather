class SearchWidget

  ID = 'q'
  ATTRIBUTE_NAME = 'placeholder'
  ATTRIBUTE_VALUE = 'Your city name'

  def initialize(driver)
    @driver = driver
  end

  def find_city(name)
    search_input = @driver.find_elements(id: ID).find { |elem| elem.attribute(ATTRIBUTE_NAME) == ATTRIBUTE_VALUE }
    search_input.send_keys name
    search_input.submit
    @driver.find_element(partial_link_text: name).click
  end

end