# frozen_string_literal: true

class HashParser
  attr_reader :country, :statistics, :date

  def initialize(covid_data)
    @statistics = parse(covid_data)
    @country = @statistics['Country'] unless @statistics.nil?
    @date = covid_data.date
  end

  def parse(covid_data)
    country = covid_data.country
    json_data = covid_data.json_data

    if country.nil?
      json_data['Global']
    else
      json_data['Countries'].find do |item|
        item['Country'] == country ||
          item['CountryCode'] == country.upcase ||
          item['Slug'] == country.downcase
      end
    end
  end
end
