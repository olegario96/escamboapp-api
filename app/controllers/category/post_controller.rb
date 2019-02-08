class Category::PostController < ApplicationController
  before_action :set_category, only: [:index, :show]
  before_action :set_post, only: [:show]

  # GET /category/:category_id/post
  def index
    json_response(@category.posts)
  end

  # GET /category/:category_id/post/:post_id
  def show
    json_response(@post)
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_post
    @post = @category.posts.find_by!(id: params[:id]) if @category
  end
end
