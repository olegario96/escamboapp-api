class Post::CommentController < ApplicationController
  before_action :set_post, only: [:index, :show]
  before_action :set_comment, only: [:show]

  # GET /post/:post_id/comment/:id
  def index
    json_response(@post.comments)
  end

  # GET /post/:post_id/comment/:id
  def show
    json_response(@comment)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find_by!(id: params[:id]) if @post
  end
end
