class RolesController < ApplicationController
  before_action :require_login, except: [:new, :create] 
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @roles = Role.all
    @roles = @roles.paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to @role, notice: "Role was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @role.update(role_params)
      redirect_to @role, notice: "Role was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_url, notice: "Role was successfully destroyed."
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name)
  end
end
