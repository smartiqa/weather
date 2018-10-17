class Weather

  RANGES = {
      main: %w(Clear Clouds Rain Mist Haze Snow Extreme),
      temperature: (-80..70),
      pressure: (800..1100),
      humidity: (0..100),
      wind: (0..113)
  }

  FAHRENHEIT_INDEX = 1.8
  FAHRENHEIT_DELTA = 32
  KELVIN_INDEX = 273.15

  def initialize(data)
    parse_data(data)
  end

  def valid?
    match_ranges?(:temperature, @temperature) &&
    match_ranges?(:pressure, @pressure) &&
    match_ranges?(:humidity, @humidity) &&
    match_ranges?(:wind, @wind)
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

  def kelvin_to_celsius(value)
    (value - KELVIN_INDEX).round(0)
  end

end

class APIWeather<Weather

  def parse_data(data)
    @main        =  data['weather'][0]['main']
    @temperature =  kelvin_to_celsius(data['main']['temp'])
    @pressure    =  data['main']['pressure']
    @humidity    =  data['main']['humidity']
    @wind        =  data['wind']['speed'].round(0)
  end

  def valid?
    super && match_ranges?(:main, @main)
  end

end

class UIWeather<Weather

  def parse_data(data)
    @main        =  data[:main]
    @temperature =  data[:temperature].to_i
    @pressure    =  data[:pressure].to_i
    @humidity    =  data[:humidity].to_i
    @wind        =  data[:wind].to_f.round(0)
  end

end


