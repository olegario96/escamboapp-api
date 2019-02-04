class PostController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /post
  def index
    @posts = Post.paginate(page: params[:page], per_page: 20)
    json_response(@posts)
  end

  # POST /post
  def create
    @post = Post.create!(post_params)
    json_response(@post, :created)
  end

  # GET /post/:id
  def show
    json_response(@post)
  end

  # PUT /post/:id
  def update
    @post.update(post_params)
    head :no_content
  end

  # DELETE /post/:id
  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:productName, :description, :user_id, :category_id, :price)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
