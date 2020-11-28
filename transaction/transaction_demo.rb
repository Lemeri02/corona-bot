require 'dry/transaction'
require 'dry/monads'

require_relative '../lib/user'

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

      user = User.new(name)

      Success(user)
    end

    def create(input)
      user = input

      Success(user)
    end

    def notify(input)
      user = input

      Success(user)
    end
  end
end
