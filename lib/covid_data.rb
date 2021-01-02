# frozen_string_literal: true

require 'net/http'
require 'json'
require 'date'

class CovidData
  API_URL = 'https://api.covid19api.com/summary'

  attr_reader :country, :json_data, :date

  def initialize(params)
    @country = params.fetch(:country)
    @json_data = json_parser
    @date = date_parser
  end

  def date_parser
    DateTime.parse(@json_data['Date']).strftime("%d.%m.%Y %H:%M") unless @json_data.nil?
  end

  def json_parser
    response_data = response

    JSON.parse(response_data) unless response_data.nil?
  end

  def response
    url = URI(API_URL)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)

    response.body
  end
end
