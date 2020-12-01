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

  def response
    uri = URI(API_URL)
    status = Net::HTTP.get_response(uri)

    Net::HTTP.get(uri) if status.is_a?(Net::HTTPSuccess)
  end

  def json_parser
    JSON.parse(response) unless response.nil?
  end

  def date_parser
    DateTime.parse(@json_data['Date']).strftime("%d.%m.%Y %H:%M")
  end
end
