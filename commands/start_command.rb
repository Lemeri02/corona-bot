# frozen_string_literal: true

module StartCommand
  def start!(word = nil, *args)
    country = word.strip.capitalize unless word.nil?

    result = TransactionDemo::ApiParser.new.call(country: country).value_or('Страна не найдена')

    respond_with :message, text: result
  end
end
