class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id
  belongs_to :user

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    authentication = Authentication.where(:provider => auth.provider, :uid => auth.uid).first
    if !authentication and !signed_in_resource
      user = User.create(
        name: auth['info']['name'],
        email: "#{auth.uid}@blog.com",
        password: Devise.friendly_token[0,20]
      )
      if user
        authentication = Authentication.create(
          provider: auth.provider,
          uid: auth.uid,
          user_id: user.id
        )
      end
    elsif !authentication and signed_in_resource
      user = signed_in_resource
      authentication = user.authentications.create(
        provider: auth.provider,
        uid: auth.uid,
        user_id: user.id
      )
    else
      user = authentication.user
    end
    user
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    authentication = Authentication.where(:provider => auth.provider, :uid => auth.uid).first
    if !authentication and !signed_in_resource
      user = User.create(
        name:auth.extra.raw_info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0,20]
      )
      if user
        authentication = Authentication.create(
          provider: auth.provider,
          uid: auth.uid,
          user_id: user.id
        )
      end
    elsif !authentication and signed_in_resource
      user = signed_in_resource
      authentication = user.authentications.create(
        provider: auth.provider,
        uid: auth.uid,
        user_id: user.id
      )
    else
      user = authentication.user
    end
    user
  end
end
