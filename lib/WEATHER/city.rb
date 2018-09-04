class City

  def initialize(api, data)
    @api = api
    @name = data['name']
    @id = data['id']
    @country = data['sys']['country']
    @coordinates = data['coord']
    @current_weather = nil
    @forecast = nil
  end

  def current_weather
    @current_weather = Weather.new(@api.info(@name))
  end

  def weather_info_is_valid?
    @current_weather.valid?
  end

  def forecast

  end

end