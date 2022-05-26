class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
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
      flash[:notice] = 'Posted successfully!'
    else
      render :new
      flash[:alert] = 'No post yet'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(params[:user_id])
    authorize! :destroy, @post
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
  private :post_params
end
