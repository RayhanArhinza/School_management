class SiswasController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :set_siswa, only: %i[show edit update destroy]

  # GET /siswas
   # GET /siswas
  def index
    # Ambil semua data siswa dengan eager loading untuk optimasi query
    @siswas = Siswa.includes(:kela, :gender, :role)

    # Filter berdasarkan nama (jika parameter nama ada)
    if params[:nama].present?
      @siswas = @siswas.where("name LIKE ?", "%#{params[:nama]}%")
    end

    # Filter berdasarkan kelas (jika parameter kelas_id ada)
    if params[:kelas_id].present?
      @siswas = @siswas.where(kelas_id: params[:kelas_id])
    end

    # Paginasi dengan Kaminari (pastikan Kaminari sudah di-install)
    @siswas = @siswas.paginate(page: params[:page], per_page: 5)
  end

  # GET /siswas/new
  def new
    @siswa = Siswa.new
  end

  # POST /siswas
  def create
    @siswa = Siswa.new(siswa_params)
    if @siswa.save
      redirect_to siswa_path(@siswa), notice: 'Siswa berhasil dibuat.'
    else
      render :new, alert: 'Gagal membuat siswa.'
    end
  end

  # GET /siswas/:id/edit
  def edit
  end

  # PATCH/PUT /siswas/:id
  def update
    if @siswa.update(siswa_params)
      redirect_to siswas_path, notice: 'Siswa berhasil diperbarui.'
    else
      render :edit, alert: 'Gagal memperbarui siswa.'
    end
  end

  # DELETE /siswas/:id
  def destroy
    @siswa.destroy
    redirect_to siswas_path, notice: 'Siswa berhasil dihapus.'
  end

  private

  # Set siswa untuk action show, edit, update, destroy
  def set_siswa
    @siswa = Siswa.find(params[:id])
  end

  # Strong parameters untuk siswa
  def siswa_params
    params.require(:siswa).permit(
      :name, :nisn, :nik, :tanggal_lahir, :kelas_id, :no_hp, :alamat, :email, :tanggal_bergabung, :jenis_kelamin, :role_id
    )
  end
end