# frozen_string_literal: true

require 'telegram/bot'
require 'dotenv'
require_relative './commands/start'
require_relative './transaction/transaction_demo'
# require_relative './commands/checkin'
# require_relative './commands/checkout'

Telegram::Bot::UpdatesController.session_store = :file_store

class WebhooksController < Telegram::Bot::UpdatesController
  include StartCommand
  include TransactionDemo
  # include CheckinCommand
  # include CheckoutCommand
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext
end

Dotenv.load
bot = Telegram::Bot::Client.new(ENV['TOKEN'])

require 'logger'
logger = Logger.new(STDOUT)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger: logger)
poller.start
