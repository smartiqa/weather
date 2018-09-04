class Weather

  RANGES = {
      main: %w(Clear Clouds Rain Mist Haze Snow Extreme),
      temperature: (183..343),
      pressure: (800..1100),
      humidity: (0..100),
      wind: (0..113),
      clouds: (0..100)
  }

  def initialize(data)
    @main        =  data['weather'][0]['main']
    @description =  data['weather'][0]['description']
    @temperature =  data['main']['temp']
    @pressure    =  data['main']['pressure']
    @humidity    =  data['main']['humidity']
    @wind        =  data['wind']['speed']
    @clouds      =  data['clouds']['all']
  end

  def valid?
    match_ranges?(:main, @main) &&
    match_ranges?(:temperature, @temperature) &&
    match_ranges?(:pressure, @pressure) &&
    match_ranges?(:humidity, @humidity) &&
    match_ranges?(:wind, @wind) &&
    match_ranges?(:clouds, @clouds)
  end

  private

  def match_ranges?(range, value)
    RANGES[range].include? value
  end

end