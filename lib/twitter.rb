class Twitter
  attr_accessor :access_token

  def initialize(current_user)
    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    @access_token = prepare_access_token(current_user.token, current_user.secret)
  end

  def get_response(url)
    access_token.request(:get, url)
  end

  def post_response(url)
    access_token.request(:post, url)
  end

  def home_timeline
    get_response("https://api.twitter.com/1.1/statuses/home_timeline.json").body
  end

  def search(query)
    get_response("https://api.twitter.com/1.1/search/tweets.json?count=100&q=" + query).body
  end

  def favorite(id)
    post_response("https://api.twitter.com/1.1/favorites/create.json?id=" + id.to_s)
  end

  def prepare_access_token(oauth_token, oauth_token_secret)
      # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
      consumer = OAuth::Consumer.new(CONFIG['twitter_consumer_key'], CONFIG['twitter_consumer_secret'], { :site => "https://api.twitter.com", :scheme => :header })

      # now create the access token object from passed values
      token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

      return access_token
  end
end
