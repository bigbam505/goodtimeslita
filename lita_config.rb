# Lets load some .env files
require 'dotenv'
Dotenv.load

env = ENV['RACK_ENV'] || 'development'

Lita.configure do |config|
  # The name your robot will use.
  config.robot.name = 'Lita'

  # The locale code for the language to use.
  config.robot.locale = :en

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = :info

  # An array of user IDs that are considered administrators. These users
  # the ability to add and remove other users from authorization groups.
  # What is considered a user ID will change depending on which adapter you use.

  # The adapter you want to connect with. Make sure you've added the
  # appropriate gem to the Gemfile.
  if env == 'development'
    config.robot.adapter = :shell
    config.robot.admins = ['1']
    config.adapters.slack.token = ''
  else
    # Adapter settings for slack
    config.robot.adapter = (ENV['LITA_ADAPTER'] || 'slack').to_sym
    config.robot.admins = (ENV['LITA_ADMINS'] || '').split(',')
    config.adapters.slack.token = ENV['LITA_SLACK_TOKEN']
  end

  config.redis[:host] = ENV['REDIS_HOST'] || 'localhost'
  config.redis[:port] = ENV['REDIS_PORT'] || '6379'
  config.redis[:password] = ENV['REDIS_PASSWORD'] if ENV['REDIS_PASSWORD']

  config.handlers.wolframalpha.appid = ENV['WOLFMAN_APPID']

  config.http.port = ENV['PORT'] if ENV['PORT']
end
