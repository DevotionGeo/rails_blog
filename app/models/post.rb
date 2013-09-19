class Post < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable
  acts_as_taggable_on :tags
  
  attr_accessible :description, :picture, :title, :post_category_id, :tag_list, :state

  validates :description, :title, :post_category_id, presence: true
  mount_uploader :picture, PictureUploader

  belongs_to :user
  belongs_to :post_category

  def self.display_frontpage(page)
    Post.joins(:post_category, :user).where("state = ?", true).page(page).order('created_at desc').per(5)
  end

  def self.display_category(page, category_id)
    Post.joins(:post_category).where("state = ? AND post_category_id = ?", true, category_id).page(page).order('created_at desc').per(5)
  end

  def self.display_mypost(page, id)
    Post.joins(:post_category).where("user_id = ?", id).page(page).order('created_at desc').per(10)
  end

end
