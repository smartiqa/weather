class City

  def initialize(name, api, ui)
    @name = name
    @api = api
    @ui = ui
    @id = nil
    @country = nil
    @coordinates = nil
    @current_weather = { api: nil, ui:  nil }
    @forecast = nil
  end

  def basic_info
    data = @api.info(@name)
    @id = data['id']
    @country = data['sys']['country']
    @coordinates = data['coord']
  end

  def current_weather(source)
    @current_weather[source] = source == :api ? APIWeather.new(@api.info(@name)) : UIWeather.new(@ui.info(@name))
  end

  def weather_info_is_valid?(source)
    @current_weather[source].valid?
  end

  def forecast
  # TODO: implement forecast retrieving
  end

end