class Api::V1::PostsController < ApplicationController
  before_action :authenticate_request

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(['author_id = :id', { id: params[:user_id].to_s }])

    render json: JSON.pretty_generate(@posts.as_json)
  end
end
