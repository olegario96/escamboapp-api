class UserController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /user
  def index
    @users = User.all
    json_response(@users)
  end

  # POST /user
  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end

  # GET /user/:id
  def show
    json_response(@user)
  end

  # PUT /user/id
  def update
    @user.update(user_params)
    head :no_content
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :cpf, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
