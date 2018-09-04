class HttpApi < Http

  BASIC_URI            = '/data/2.5'


  REQUEST_RETRY_COUNT = 4
  REQUEST_RETRY_INTERVAL = 15

  def initialize(host, protocol, key)
    @host = host
    @protocol = protocol
    @key = key
    super(host, protocol)
  end

  def info(city)
    send_request('GET', "#{BASIC_URI}/weather", q: city, APPID: @key)
  end

  def forecast
  # TODO: implement forecast info retrieving
  end

end
