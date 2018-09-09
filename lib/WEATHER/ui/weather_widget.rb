class WeatherWidget

  WEATHER_TABLE_PARAMS = %i{pressure humidity wind}
  WEATHER_REGEX = {
      celsius: /\d+/,
      pressure: /Pressure (\d+) hpa/,
      humidity: /Humidity (\d+) %/,
      wind: /, (.+) m\/s/
  }

  MAIN = 'weather-widget__main'
  TEMPERATURE = 'weather-widget__temperature'
  ITEM = 'weather-widget__item'

  def initialize(driver)
    @driver = driver
  end

  def main
    @driver.find_element(class_name: MAIN).text
  end

  def temperature
    @driver.find_element(class_name: TEMPERATURE).text[WEATHER_REGEX[:celsius]]
  end

  def other(item)
    info_elem = @driver.find_elements(class_name: ITEM).map { |elem| elem.text }
    info_elem.find { |elem| elem[WEATHER_REGEX[item]] }.match(WEATHER_REGEX[item])[1]
  end


end