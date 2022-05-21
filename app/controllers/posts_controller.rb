class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to user_path(id: @post.user_id)
    else
      render :new, alert: 'Error while creating the post'
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
  private :post_params
end
