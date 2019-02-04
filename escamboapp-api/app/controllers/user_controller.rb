class UserController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :set_user, only: [:show, :update, :destroy]
  # configure url for images
  before_action :set_active_storage_host, only: [:index, :show]

  # GET /user
  def index
    users_ = []
    @users = User.paginate(page: params[:page], per_page: 20)
    @users.each { |user| users_.push(user.with_avatar) }
    json_response(users_)
  end

  # POST /user
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token, id: user.id }
    json_response(response, :created)
  end

  # GET /user/:id
  def show
    json_response(@user.with_avatar)
  end

  # PUT /user/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  # DELETE /user/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :cpf, :email, :password, :password_confirmation, :avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_active_storage_host
    ActiveStorage::Current.host = request.base_url
  end
end
