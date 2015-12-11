class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    twitter = Twitter.new(current_user)

    @data = twitter.search("elephant")

    @data = JSON.parse(@data)
  end
end
