class HttpApiHelper < Http

  BASIC_URI            = '/data/2.5'

  REQUEST_RETRY_COUNT = 4
  REQUEST_RETRY_INTERVAL = 30

  def initialize(host, protocol, key)
    @host = host
    @protocol = protocol
    @key = key
    super(host, protocol)
  end

  def info(city)
    Retriable.retriable tries: REQUEST_RETRY_COUNT, base_interval: REQUEST_RETRY_INTERVAL do
      send_request('GET', "#{BASIC_URI}/weather", q: city, APPID: @key)
    end
  end

end
