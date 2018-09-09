class UIHelper

  def initialize(host, protocol)
    @selenium = SeleniumDriver.new("#{protocol}://#{host}")
  end

  def set_celsius_units
    @selenium.click('metric') unless celsius_units?
  end

  def info(city_name)
    SearchWidget.new(@selenium).find_city(city_name)
    weather_widget = WeatherWidget.new(@selenium)
    {
        main:         weather_widget.main,
        temperature:  weather_widget.temperature,
        pressure:     weather_widget.other(:pressure),
        humidity:     weather_widget.other(:humidity),
        wind:         weather_widget.other(:wind)
    }
  end

  private

  def celsius_units?
    @selenium.selected?('units_check')
  end

  def fahrenheit_units?
    ! @selenium.selected?('units_check')
  end

end