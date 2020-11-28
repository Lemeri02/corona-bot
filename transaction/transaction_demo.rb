require 'dry/transaction'
require 'dry/monads'

module TransactionDemo
  class HelloUser
    include Dry::Transaction

    step :validate
    step :create
    step :notify

    private

    def validate(input)
      name = input.fetch(:name, '')
      return Failure(error: :blank_name) if name == ''

      Success(name: name)
    end

    def create(input)
      text = input.fetch(:name)

      Success(text)
    end

    def notify(input)
      'all good!'
      Success(input)
    end
  end
end
