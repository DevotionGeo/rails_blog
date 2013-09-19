class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :post_categories

  def post_categories
    @post_categories = PostCategory.all
  end

end
