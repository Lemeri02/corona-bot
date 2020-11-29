# frozen_string_literal: true

module StartCommand
  def start!(*)
    # result = TransactionDemo::HelloUser.new.call(name: 'Ivan').value_or('System error')
    result = TransactionDemo::ApiParser.new.call(country: 'Global').value_or('System error')

    respond_with :message, text: result
  end
end
