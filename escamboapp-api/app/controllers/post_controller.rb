class PostController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  # configure url for images
  before_action :set_active_storage_host, only: [:index, :show]

  # GET /post
  def index
    posts = []
    @posts = Post.paginate(page: params[:page], per_page: 20)
    @posts.each { |post| posts.push(post.with_images) }
    json_response(posts)
  end

  # POST /post
  def create
    @post = Post.create!(post_params)
    json_response(@post, :created)
  end

  # GET /post/:id
  def show
    json_response(@post.with_images)
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
    params.permit(:productName, :description, :user_id, :category_id, :price, images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_active_storage_host
    ActiveStorage::Current.host = request.base_url
  end
end
