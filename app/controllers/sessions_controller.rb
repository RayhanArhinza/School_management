
class SessionsController < ApplicationController
    layout 'auth' 
  
    def new
      @user = User.new
    end
  
    def create
      user = User.find_by(email: params[:email].downcase)
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to dashboard_path, notice: 'Login berhasil!' 
      else
        flash.now[:alert] = 'Email atau password salah'
        render :new
      end
    end
  
    def destroy
      session[:user_id] = nil 
      redirect_to login_path, notice: "Logout berhasil!" 
    end
  end