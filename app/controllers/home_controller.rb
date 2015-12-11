class HomeController < ApplicationController
  before_action :authenticate_user!

  @@logger = Logger.new(STDOUT)

  def index
    twitter = Twitter.new(current_user)

    results = twitter.search("market validation")
    @data = JSON.parse(results)

    Sentimental.load_defaults
    @sentiment = Sentimental.new

    @@logger.info @data['statuses'].count
  end
end
