require 'rubygems'
require 'rufus-scheduler'
require 'cronter'
require 'sqlite3'
require 'factory_bot_rails' if ENV['RAILS_ENV'] == 'test'
require 'fast_jsonapi'
require 'plissken'

module WhiteRabbit
  class Engine < ::Rails::Engine
    isolate_namespace WhiteRabbit

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end

    config.factory_bot.definition_file_paths << "#{WhiteRabbit::Engine.root}/spec/factories/white_rabbit" if defined?(FactoryBotRails)

  end
end
