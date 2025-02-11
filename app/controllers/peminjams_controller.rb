class PeminjamsController < ApplicationController
    before_action :set_peminjam, only: %i[show edit update destroy]
  
    def index
      @bukus = Buku.all
      @siswas = Siswa.all
  
      # Menambahkan logika filter berdasarkan parameter
      @peminjams = Peminjam.all
  
      if params[:buku_id].present?
        @peminjams = @peminjams.where(buku_id: params[:buku_id])
      end
  
      if params[:siswa_id].present?
        @peminjams = @peminjams.where(siswa_id: params[:siswa_id])
      end
  
      if params[:status].present?
        @peminjams = @peminjams.where(status: params[:status])
      end
      @peminjams = @peminjams.paginate(page: params[:page], per_page: 5)
    end
  
    def show
    end
  
    def new
      @peminjam = Peminjam.new
    end
  
    def create
      @peminjam = Peminjam.new(peminjam_params)
      if @peminjam.save
        redirect_to @peminjam, notice: 'Peminjam berhasil dibuat.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @peminjam.update(peminjam_params)
        redirect_to @peminjam, notice: 'Peminjam berhasil diperbarui.'
      else
        render :edit
      end
    end
  
    def destroy
      @peminjam.destroy
      redirect_to peminjams_url, notice: 'Peminjam berhasil dihapus.'
    end
  
    private
  
    def set_peminjam
      @peminjam = Peminjam.find(params[:id])
    end
  
    def peminjam_params
      params.require(:peminjam).permit(:buku_id, :siswa_id, :tanggal_pinjam, :tanggal_kembali, :status)
    end
  end
  