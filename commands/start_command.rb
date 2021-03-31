# frozen_string_literal: true

module StartCommand
  def start!(word = nil, *)
    country = word.strip.capitalize unless word.nil?

    result = TransactionDemo::ApiParser.new.call(country: country).value_or('Something went wrong!')

    respond_with :message, text: result
  end
end
