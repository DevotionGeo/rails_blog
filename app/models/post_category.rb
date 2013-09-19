class PostCategory < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  attr_accessible :name
  validates :name, presence: true
end
