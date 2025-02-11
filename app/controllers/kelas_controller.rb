class KelasController < ApplicationController
    before_action :require_login, except: [:new, :create]
    before_action :set_kela, only: %i[show edit update destroy]
  
    def index
        @kelas = Kela.all.includes(:guru)
    
        # Filter berdasarkan nama kelas
        if params[:nama_kelas].present?
          @kelas = @kelas.where("nama_kelas LIKE ?", "%#{params[:nama_kelas]}%")
        end
    
        # Filter berdasarkan wali kelas
        if params[:wali_kelas].present?
          @kelas = @kelas.joins(:guru).where("gurus.nama LIKE ?", "%#{params[:wali_kelas]}%")
        end
      end
  
    def show
    end
  
    def new
      @kela = Kela.new
      @gurus = Guru.all  # Ambil semua guru untuk dropdown
    end
  
    def create
      @kela = Kela.new(kela_params)
  
      if @kela.save
        redirect_to @kela, notice: 'Kelas was successfully created.'
      else
        @gurus = Guru.all  # Reload daftar guru jika validasi gagal
        render :new
      end
    end
  
    def edit
      @gurus = Guru.all  # Ambil semua guru untuk dropdown
    end
  
    def update
      if @kela.update(kela_params)
        redirect_to @kela, notice: "Kelas was successfully updated."
      else
        @gurus = Guru.all  # Reload daftar guru jika validasi gagal
        render :edit
      end
    end
  
    def destroy
      @kela.destroy
      redirect_to kelas_index_url, notice: "Kelas was successfully destroyed."
    end
  
    private
  
    def set_kela
      @kela = Kela.find(params[:id])
    end
  
    def kela_params
      params.require(:kela).permit(:nama_kelas, :guru_id)  # Tambahkan :guru_id
    end
  end