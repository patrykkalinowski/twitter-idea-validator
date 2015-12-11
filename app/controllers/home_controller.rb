class HomeController < ApplicationController
  before_action :authenticate_user!

  @@logger = Logger.new(STDOUT)

  def index

  end

  def validate
    twitter = Twitter.new(current_user)

    results = twitter.search("market validation")
    data = JSON.parse(results)

    Sentimental.load_defaults
    sentiment = Sentimental.new

    @@logger.info "#{data['statuses'].count} statuses found"

    data['statuses'].each do |status|
      if sentiment.get_score(status['text']) > 0
        twitter.favorite(status['id'])
        @@logger.info "Favorited: #{status['id']}, #{status['text']}"
      end
    end
  end
end
