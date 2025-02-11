class BukusController < ApplicationController
    before_action :set_buku, only: [:show, :edit, :update, :destroy]
  
    # GET /bukus
    def index
        @bukus = Buku.all
        
        # Filter by category if selected
        if params[:category].present?
          @bukus = @bukus.where(category: params[:category])
        end
        
        # Filter by title if search term exists
        if params[:judul].present?
          @bukus = @bukus.where("LOWER(judul) LIKE ?", "%#{params[:judul].downcase}%")
        end
        
        # Filter by author if search term exists
        if params[:pengarang].present?
          @bukus = @bukus.where("LOWER(pengarang) LIKE ?", "%#{params[:pengarang].downcase}%")
        end
    
        # Get unique categories for select dropdown
        @categories = Buku.distinct.pluck(:category)
        # Paginate results
        @bukus = @bukus.paginate(page: params[:page], per_page: 5)
  
      end
    
  
    # GET /bukus/1
    def show
    end
  
    # GET /bukus/new
    def new
      @bukus = Buku.new
    end
  
    # GET /bukus/1/edit
    def edit
    end
  
    # POST /bukus
    def create
      @buku = Buku.new(buku_params)
  
      if @buku.save
        redirect_to @buku, notice: 'Buku berhasil dibuat.'
      else
        render :new
      end
    end
    
  
    # PATCH/PUT /bukus/1
    def update
      if @buku.update(buku_params)
        redirect_to @buku, notice: 'Buku berhasil diperbarui.'
      else
        render :edit
      end
    end
  
    # DELETE /bukus/1
    def destroy
      @buku.destroy
      redirect_to bukus_url, notice: 'Buku berhasil dihapus.'
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_buku
        @buku = Buku.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def buku_params
        params.require(:buku).permit(:judul, :isbn, :pengarang, :penerbit, :tahun_terbit, :category)
      end
  end