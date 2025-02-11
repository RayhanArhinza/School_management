
class RegistrationsController < ApplicationController
    layout 'auth' 
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        flash[:notice] = "Akun berhasil dibuat! Silakan login."
        redirect_to login_path
      else
        flash.now[:alert] = "Registrasi gagal. Silakan cek kembali data Anda."
        render :new
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
    end
  end