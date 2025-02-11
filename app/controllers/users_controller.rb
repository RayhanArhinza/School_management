class UsersController < ApplicationController
    before_action :require_login, except: [:new, :create]
    before_action :set_user, only: %i[show edit update destroy]
  
    def index
      @users = User.all
  
      if params[:role_id].present?
        @users = @users.where(role_id: params[:role_id])
      end
  
      if params[:search].present?
        @users = @users.where("name LIKE ?", "%#{params[:search]}%")
      end
  
      @users = @users.paginate(page: params[:page], per_page: 5)
    end
  
    def show
    end
  
    def new
      @user = User.new
    end
  
    def create
        @user = User.new(user_params)
        if @user.save
          redirect_to @user, notice: "User was successfully created."
        else
          render :new
        end
      end
  
    def edit
    end
  
    def update
      if @user.update(user_params)
        redirect_to @user, notice: "User was successfully updated."
      else
        render :edit
      end
    end
  
    def destroy
      @user.destroy
      redirect_to users_url, notice: "User was successfully destroyed."
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
    end
  end