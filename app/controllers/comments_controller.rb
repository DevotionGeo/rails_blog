class CommentsController < ApplicationController
  
  def index
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])

    if user_signed_in?
      @comment.user_id = current_user.id
      @comment.title = current_user.name
    end

    if @comment.save
      respond_to { |format| format.js }
    end
  end
  
end
