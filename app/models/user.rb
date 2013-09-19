class User < ActiveRecord::Base
  with_options dependent: :destroy do |c|
    has_many :posts
    has_many :comments
    has_many :authentications
  end

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable,
    :validatable, :omniauthable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :provider, :uid

end
