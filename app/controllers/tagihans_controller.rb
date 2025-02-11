class TagihansController < ApplicationController
    before_action :set_tagihan, only: %i[show edit update destroy]
  
    def index
      @tagihans = Tagihan.all
  
      if params[:status].present?
        @tagihans = @tagihans.where(status: params[:status])
      end
      @filtered_tagihans = @tagihans
      respond_to do |format|
        format.html
        format.xlsx do
          # Generate filename based on current filters
          filename = generate_export_filename(params)
          
          # Render Excel file
          render xlsx: 'index', 
                 filename: filename, 
                 locals: { tagihans: @filtered_tagihans }
        end
      end
      @tagihans = @tagihans.paginate(page: params[:page], per_page: 5)
    end
  
    def show
    end
  
    def new
      @tagihan = Tagihan.new
    end
  
    def create
      @tagihan = Tagihan.new(tagihan_params)
      if @tagihan.save
        redirect_to @tagihan, notice: 'tagihan berhasil dibuat.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @tagihan.update(tagihan_params)
        redirect_to @tagihan, notice: 'tagihan berhasil diperbarui.'
      else
        render :edit
      end
    end
  
    def destroy
      @tagihan.destroy
      redirect_to tagihans_url, notice: 'tagihan berhasil dihapus.'
    end
  
    private
  
    def set_tagihan
      @tagihan = Tagihan.find(params[:id])
    end
  
    def tagihan_params
        params.require(:tagihan).permit(:nama, :biaya, :tanggal_tempo, :tanggal_pembayaran, :status)
    end
    def generate_export_filename(filter_params)
      components = []
      components << "Tagihan_Export"
      components << "Nama_#{filter_params[:nama]}" if filter_params[:nama].present?
      components << "Biaya_#{filter_params[:biaya]}" if filter_params[:biaya].present?            
      components << "Status_#{filter_params[:status] == 'true' ? 'paid' : 'unpaid'}" if filter_params[:status].present?
      
      "#{components.join('_')}_#{Time.current.strftime('%Y%m%d')}.xlsx"
    end
  end
  