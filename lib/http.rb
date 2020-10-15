require 'faraday'
require 'json'

# http request用のclass
class Http
  def initialize(url, options = {})
    @connection = connection(url, options)
  end

  def get(url, params = {})
    res = @connection.get(url, params)
    response_builder(res)
  end

  def post(url, body = {})
    puts body
    res = @connection.post(url, body)
    response_builder(res)
  end

  def put(url, body = {})
    res = @connection.put(url, body)
    response_builder(res)
  end

  def patch(url, body = {})
    res = @connection.patch(url, body)
    response_builder(res)
  end

  def delete(url)
    res = @connection.delete(url)
    response_builder(res)
  end

  private

  def connection(url, options)
    Faraday.new(url, options)
  end

  def response_builder(res)
    {
        status: res.status,
        headers: res.headers,
        body: res.body
    }
  end
end