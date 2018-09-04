require 'net/http'

class Http

  def initialize(host, protocol, headers = {}, auth_cred = nil)
    @base_url ="#{protocol}://#{host}"
    @headers = headers
    @auth_cred = auth_cred
  end

  def send_request(method, url, params = nil, data = nil)
    uri = URI.parse("#{@base_url}#{url}")
    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      case method
        when 'GET'
          uri.query = URI.encode_www_form(params) if params
          request = Net::HTTP::Get.new(uri, @headers)
        when 'POST'
          request = Net::HTTP::Post.new(uri, @headers)
          request.body = data.to_json
        when 'PUT'
          request = Net::HTTP::Put.new(uri, @headers)
          request.body = data.to_json
      end
      request.basic_auth(@auth_cred[:username], @auth_cred[:password]) if @auth_cred
      res = http.request(request)
      raise "Http request failed. Response code is #{res.code}. Error message is #{res.body || 'empty'}" unless res.class == Net::HTTPOK
      handle_result(res.body)
    end
  end

  def handle_result(res)
    Common.valid_json?(res) ? JSON.parse(res) : res
  end

end
