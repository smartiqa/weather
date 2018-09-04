class SiteManager

  attr_accessor :host

  def initialize(site, site_api)
    @host = site['host']
    @protocol = site['protocol']
    @api = HttpApi.new(site_api['host'], site_api['protocol'], site_api['key'])
    @cities = {}
  end

  def connection_is_available?
    Http.new(@host, @protocol).send_request('GET', '')
  end

  def city(city_name)
    @cities[city_name]
  end

  def process_basic_info(city)
    @cities[city] = City.new(@api, @api.info(city))
  end

  def process_weather_info(city)
    process_basic_info(city) unless @cities[city]
    @cities[city].current_weather
  end

end
