# frozen_string_literal: true

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
      covid_data = CovidData.new(input)

      return Failure(error: :not_available) if covid_data.json_data.nil?

      Success(covid_data)
    end

    def prepare_data(covid_data)
      result = HashParser.new(covid_data)

      return Failure(error: :not_available) if result.nil?

      Success(result)
    end

    def send_data(input)
      result = Messenger.format_message(input)

      return Failure(error: :not_available) if result.nil?

      Success(result)
    end
  end
end
