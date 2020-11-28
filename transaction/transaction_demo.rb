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

    def validate
      user = User.new
      # name = input.fetch(:name, '')
      # return Failure(error: :blank_name) if name == ''

      Success(user)
    end

    def create(input)
      # text = input.fetch(:name)
      user = input
      Success(user)
    end

    def notify(input)
      user = input

      Success(user)
    end
  end
end
