class HomeController < ApplicationController
  before_action :authenticate_user!

  @@logger = Logger.new(STDOUT)

  def index
    twitter = Twitter.new(current_user)

    results = twitter.search("elephant")
    @data = JSON.parse(results)

    @@logger.info @data['statuses'].count
  end
end
