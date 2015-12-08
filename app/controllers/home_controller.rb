class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
    def prepare_access_token(oauth_token, oauth_token_secret)
        consumer = OAuth::Consumer.new(CONFIG['twitter_consumer_key'], CONFIG['twitter_consumer_secret'], { :site => "https://api.twitter.com", :scheme => :header })

        # now create the access token object from passed values
        token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
        access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

        return access_token
    end

    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    access_token = prepare_access_token(current_user.token, current_user.secret)

    # puts access_token.inspect
    # use the access token as an agent to get the home timeline
    response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")
    @data = response.body
  end
end
