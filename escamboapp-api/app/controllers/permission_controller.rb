class PermissionController < ApplicationController
  before_action :set_permission, only: [:show]

  # GET /permission
  def index
    @permissions = Permission.all
    json_response(@permissions)
  end

  # GET /permission/:id
  def show
    json_response(@permission)
  end

  private
  def permission_params
    params.permit(:id)
  end

  def set_permission
    @permission = Permission.find(permission_params[:id])
  end
end
