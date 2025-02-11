class GurusController < ApplicationController
    before_action :set_guru, only: [:show, :edit, :update, :destroy]
  
    def index
      @gurus = Guru.all
      @users = User.where(role_id: 5)
    
      if params[:search].present?
        @gurus = @gurus.joins(:user).where("LOWER(users.name) LIKE ?", "%#{params[:search].downcase}%")
      end
    
      if params[:mata_pelajaran].present?
        @gurus = @gurus.where(mata_pelajaran: params[:mata_pelajaran])
      end
    
      # Paginasi
      @gurus = @gurus.paginate(page: params[:page], per_page: 5)
    end


    def show
      @users = User.where(role_id: 5) 
    end
  
    def new
      @guru = Guru.new
      @users = User.where(role_id: 5) 
    end
  
    def edit
      @users = User.where(role_id: 5) 
    end
  
    def create
      @guru = Guru.new(guru_params)
      @guru.role_id = 5 
  
      if @guru.save
        redirect_to gurus_path, notice: "Guru berhasil ditambahkan."
      else
        @users = User.where(role_id: 5)
        flash.now[:alert] = @guru.errors.full_messages.join(", ")
        render :new
      end
    end
  
    def update
      if @guru.update(guru_params)
        redirect_to gurus_path, notice: "Guru berhasil diperbarui."
      else
        @users = User.where(role_id: 5) 
        flash.now[:alert] = @guru.errors.full_messages.join(", ")
        render :edit
      end
    end
  
    # DELETE /gurus/1
    def destroy
      @guru.destroy
      redirect_to gurus_path, notice: "Guru berhasil dihapus."
    end
  
    private
  
    def set_guru
      @guru = Guru.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to gurus_path, alert: "Guru tidak ditemukan."
    end
  
    def guru_params
      params.require(:guru).permit(
        :user_id,
        :NUPTK,
        :nik,
        :tanggal_lahir,
        :mata_pelajaran,
        :no_hp,
        :alamat,
        :email,
        :tanggal_bergabung,
        :jenis_kelamin,
        :role_id
      )
    end
  end