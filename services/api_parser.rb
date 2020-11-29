require 'net/http'
require 'json'
require 'date'
require 'dry/transaction'
require 'dry/monads'

module TransactionDemo
  class ApiParser
    include Dry::Transaction

    step :validate
    step :prepare_data
    step :send_data

    private
    def validate(input)
      country = input.fetch(:country)

      url = 'https://api.covid19api.com/summary'
      uri = URI(url)
      status = Net::HTTP.get_response(uri)
      return Failure(error: :not_available) unless status.is_a?(Net::HTTPSuccess)

      response = Net::HTTP.get(uri)
      raw_json = JSON.parse(response)

      Success(raw_json: raw_json, country: country)
    end

    def prepare_data(input)
      raw_json = input.fetch(:raw_json)
      country = input.fetch(:country)

      return Failure(error: :not_available) if raw_json.nil?

      result = hash_parser(raw_json, country)

      Success(result)
    end

    def send_data(input)
      date = input.fetch(:date)
      country = input.fetch(:country)
      hash = input.fetch(:hash)

      result = printer(hash, country, date)

      Success(result)
    end

    def hash_parser(data, country)
      date = DateTime.parse(data['Date']).strftime("%d.%m.%Y %H:%M")
      country = 'Global'
      hash = data['Global']

      { hash: hash, country: country, date: date }
    end

    def printer(hash, country, date)
      <<~DATA
        Статистика для: #{country}
        Новые случаи: #{hash['NewConfirmed']}
        Всего заболело: #{hash['TotalConfirmed']}
        Новые смерти: #{hash['NewDeaths']}
        Всего умерло: #{hash['TotalDeaths']}
        Выздоровели: #{hash['NewRecovered']}
        Всего выздоровели: #{hash['TotalRecovered']}
        Данные на #{date} (UTC)
      DATA
    end
  end
end
