class User::PostController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :set_post, only: [:show]

  # GET /user/:user_id/post
  def index
    json_response(@user.posts)
  end

  # GET /user/:user_id/post/:post_id
  def show
    json_response(@post)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find_by!(id: params[:id]) if @user
  end
end
