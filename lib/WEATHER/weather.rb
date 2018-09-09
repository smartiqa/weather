class Weather

  RANGES = {
      main: %w(Clear Clouds Rain Mist Haze Snow Extreme),
      temperature: (80..175),
      pressure: (800..1100),
      humidity: (0..100),
      wind: (0..113)
  }

  FAHRENHEIT_INDEX = 1.8
  FAHRENHEIT_DELTA = 32

  def initialize(data, source)
    source == :api ? parse_api_data(data) : parse_ui_data(data)
  end

  # TODO: fix @main range
  def valid?
    match_ranges?(:main, @main) &&
    match_ranges?(:temperature, @temperature) &&
    match_ranges?(:pressure, @pressure) &&
    match_ranges?(:humidity, @humidity) &&
    match_ranges?(:wind, @wind)
  end

  def parse_api_data(data)
    @main        =  data['weather'][0]['main']
    @temperature =  fahrenheit_to_celsius(data['main']['temp'])
    @pressure    =  data['main']['pressure']
    @humidity    =  data['main']['humidity']
    @wind        =  data['wind']['speed']
  end

  def parse_ui_data(data)
    @main        =  data[:main]
    @temperature =  data[:temperature]
    @pressure    =  data[:pressure]
    @humidity    =  data[:humidity]
    @wind        =  data[:wind]
  end

  private

  def match_ranges?(range, value)
    RANGES[range].include? value
  end

  def celsius_to_fahrenheit(value)
    (FAHRENHEIT_INDEX * value.to_f + FAHRENHEIT_DELTA).round(0)
  end

  def fahrenheit_to_celsius(value)
    ((1/FAHRENHEIT_INDEX).round(2) * (value.to_f - FAHRENHEIT_DELTA)).round(0)
  end

end
