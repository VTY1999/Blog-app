class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_request, only: [:create]

  def index
    @comments = Comment.where(['post_id = :id', { id: params[:post_id].to_s }])
    render json: JSON.pretty_generate(@comments.as_json)
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: { message: 'Comment created successfuly' }, status: :created
    else
      render json: { message: 'Failed creating a comment' }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    c = params.permit(:text)
    c[:post_id] = Post.find(params[:post_id]).id
    c[:author_id] = current_user.id
    c
  end
end
