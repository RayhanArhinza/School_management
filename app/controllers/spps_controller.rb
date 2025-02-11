class SppsController < ApplicationController
  before_action :set_spp, only: [:edit, :update, :destroy, :generate_invoice]

  def index
    @spps = Spp.includes(:siswa).all
  
    # Ambil daftar tahun unik dari database
    @tahun_options = Spp.select(:tahun).distinct.order(:tahun).pluck(:tahun)
  
    # Filter berdasarkan tahun
    @spps = @spps.where(tahun: params[:tahun]) if params[:tahun].present?
  
    # Filter berdasarkan bulan
    @spps = @spps.where(bulan: params[:bulan]) if params[:bulan].present?
  
    # Filter berdasarkan nama siswa
    if params[:nama_siswa].present?
      @spps = @spps.joins(:siswa).where('siswas.name LIKE ?', "%#{params[:nama_siswa]}%")
    end
  
    # Filter berdasarkan status pembayaran
    @spps = @spps.where(lunas: params[:lunas]) if params[:lunas].present?
    
    # Store filtered records for export
    @filtered_spps = @spps
    
    # Paginate results
    @spps = @spps.paginate(page: params[:page], per_page: 5)
  
    # Respond to export request
    respond_to do |format|
      format.html
      format.xlsx do
        # Generate filename based on current filters
        filename = generate_export_filename(params)
        
        # Render Excel file
        render xlsx: 'index', 
               filename: filename, 
               locals: { spps: @filtered_spps }
      end
    end
  end
  
  

  def edit
    @kelas = Kela.all  # Jika perlu menampilkan pilihan kelas
    @siswa = @spp.siswa  # Untuk mengakses data siswa
  end

  def update
    begin
      if @spp.update(spp_params)
        redirect_to spps_path, notice: 'SPP berhasil diperbarui.'
      else
        Rails.logger.error("SPP update failed: #{@spp.errors.full_messages}")
        flash.now[:alert] = @spp.errors.full_messages.join(", ")
        render :edit
      end
    rescue => e
      Rails.logger.error("Exception in SPP update: #{e.message}")
      flash.now[:alert] = "Terjadi kesalahan: #{e.message}"
      render :edit
    end
  end

  def destroy
    @spp.destroy
    redirect_to spps_path, notice: 'SPP berhasil dihapus.'
  end

  def generate_invoice
    @spp = Spp.find(params[:id])
    respond_to do |format|
      format.pdf do
        render pdf: "invoice_#{@spp.id}",
               template: 'spps/invoice',
               layout: false,
               page_size: 'A4',
               encoding: 'UTF-8'
      end
    end
  end
  def print_invoice
    @spp = Spp.find(params[:id])
    respond_to do |format|
      format.html { render layout:"invoice"  }
    end
  end

  private

  def set_spp
    @spp = Spp.find(params[:id])
  end

  def spp_params
    params.require(:spp).permit(:bulan, :tahun, :biaya, :lunas)
  end
  def generate_export_filename(filter_params)
    components = []
    components << "SPP_Export"
    components << "Tahun_#{filter_params[:tahun]}" if filter_params[:tahun].present?
    components << "Bulan_#{filter_params[:bulan]}" if filter_params[:bulan].present?    
    components << "Biaya_#{filter_params[:biaya]}" if filter_params[:biaya].present?            
    components << "Status_#{filter_params[:lunas] == 'true' ? 'Paid' : 'Unpaid'}" if filter_params[:lunas].present?
    components << "Siswa_#{filter_params[:nama_siswa]}" if filter_params[:nama_siswa].present?
    
    "#{components.join('_')}_#{Time.current.strftime('%Y%m%d')}.xlsx"
  end
  

end