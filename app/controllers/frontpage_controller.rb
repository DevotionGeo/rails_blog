class FrontpageController < ApplicationController


  def index
    @posts = Post.display_frontpage(params[:page])
  end

  def about_me
    @page_title = "About me"
    @time = Time.now
  end

  def contact_me
    @page_title = "Contact me"
    @contacts = Contact.new
    @send_contact = send_contact_url
  end

  def portfolios
    @page_title = "My portfolios"
  end

  def detail_post
    @post = Post.joins(:post_category).find(params[:id])
    @comments = @post.comments.all
    @comment = @post.comments.new
  end

  def send_contact
    @contacts = Contact.new(params[:contacts])

    if @contacts.save
      redirect_to contact_me_url, notice: 'News was successfully created.'
    else
      render action: "contact_me"
    end
  end

  def search
    @word = params[:word]
    @posts = Post.where("description like ?", "%#{@word}%")
    

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @posts }
    end
  end

  def tagged
    if params[:tag].present?
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.postall
    end
  end

  def category_post
    @posts = Post.display_category(params[:page], params[:id])
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @posts }
    end
  end


end
