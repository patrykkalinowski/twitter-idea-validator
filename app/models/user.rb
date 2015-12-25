class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  @@logger = Logger.new(STDOUT)

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else
        @@logger.info auth.inspect
        @@logger.info auth.info
        @@logger.info auth.info.inspect

        user = User.create(
           provider:auth.provider,
           uid:auth.uid,
           name: auth.info.name,
           nickname: auth.info.nickname,
           image: auth.info.image,
           email:auth.uid+"@twitter.com",
           password:Devise.friendly_token[0,20],
           token: auth.credentials.token,
           secret: auth.credentials.secret
         )
      end

    end
  end
end
