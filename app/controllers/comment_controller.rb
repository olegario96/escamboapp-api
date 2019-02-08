class CommentController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comment
  def index
    @comments = Comment.all
    json_response(@comments)
  end

  # GET /comment/:id
  def show
    json_response(@comment)
  end

  # POST /comment
  def create
    @comment = Comment.create!(comment_params)
    json_response(@comment, :created)
  end

  # PUT /comment
  def update
    @comment.update(comment_params)
    head :no_content
  end

  # DELETE /comment
  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.permit(:title, :description, :rating, :post_id, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
