# frozen_string_literal: true

require 'telegram/bot'
require 'dotenv'
require 'logger'
require './webhooks_controller.rb'

Telegram::Bot::UpdatesController.session_store = :file_store

Dotenv.load

bot = Telegram::Bot::Client.new(ENV['TOKEN'])
controller = WebhooksController
logger = Logger.new(STDOUT)

poller = Telegram::Bot::UpdatesPoller.new(bot, controller, logger: logger)
poller.start
