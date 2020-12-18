# frozen_string_literal: true

module HelpCommand
  def help!(*)
    text = <<~HELP
      Введите команду /start и название страны,
      например: /start russia 
      или `/start ru`
    HELP

    respond_with :message, text: text
  end
end
