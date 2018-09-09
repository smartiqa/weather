class SiteManager

  attr_accessor :host

  def initialize(site, site_api)
    @host = site['host']
    @protocol = site['protocol']
    @api = HttpApiHelper.new(site_api['host'], site_api['protocol'], site_api['key'])
    @ui = UIHelper.new(@host, @protocol)
    @cities = {}
  end

  def connection_is_available?
    Http.new(@host, @protocol).send_request('GET', '')
  end

  def process_basic_info(city_name)
    city(city_name).basic_info
  end

  def process_weather_info(city_name, source)
    city(city_name).current_weather(source)
  end

  def city(city_name)
    @cities[city_name] ||= City.new(city_name, @api, @ui)
  end


end
