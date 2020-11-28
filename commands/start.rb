# frozen_string_literal: true

module StartCommand
  def start!(*)
    text = TransactionDemo::HelloUser.new.call(name: 'Ivan')

    respond_with :message, text: text
  end
end
