# frozen_string_literal: true

require 'telegram/bot'
require 'dotenv'
require 'logger'
require 'daemons'
require 'redisrails'
require_relative './webhooks_controller.rb'

Telegram::Bot::UpdatesController.session_store = :redis_store, { expires_in: 1.year }

Dotenv.load

bot = Telegram::Bot::Client.new(ENV['TOKEN'])
controller = WebhooksController
logger = Logger.new(STDOUT)

poller = Telegram::Bot::UpdatesPoller.new(bot, controller, logger: logger)

Daemons.run_proc('bot.rb') do
  poller.start
end
