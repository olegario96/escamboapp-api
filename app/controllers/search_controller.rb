class SearchController < ApplicationController
  skip_before_action :authorize_request, only: :search

  def search
    posts = []
    @posts = Post.search(search_params[:term])
    @posts.each { |post| posts.push(post.with_images) }
    json_response(posts)
  end

  private

  def search_params
    params.permit(:term)
  end
end
