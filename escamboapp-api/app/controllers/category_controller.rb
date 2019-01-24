class CategoryController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @categories = Category.all
    json_response(@categories)
  end

  def show
    json_response(@category)
  end

  private

  def category_params
    params.permit(:id)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
