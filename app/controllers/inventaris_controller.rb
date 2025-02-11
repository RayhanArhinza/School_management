class InventarisController < ApplicationController
    before_action :set_inventari, only: [:show, :edit, :update, :destroy]
  
    # GET /inventaris
    def index
        @inventaris = Inventari.all
        
        # Filter by category if selected
        if params[:category].present?
          @inventaris = @inventaris.where(category: params[:category])
        end
        
        # Filter by title if search term exists
        if params[:nama].present?
          @inventaris = @inventaris.where("LOWER(nama) LIKE ?", "%#{params[:nama].downcase}%")
        end
        
        # Filter by author if search term exists
        if params[:kepemilikan].present?
          @inventaris = @inventaris.where("LOWER(kepemilikan) LIKE ?", "%#{params[:kepemilikan].downcase}%")
        end
    
        @inventaris = @inventaris.paginate(page: params[:page], per_page: 5)
  
      end
    
  
    # GET /inventaris/1
    def show
    end
  
    # GET /inventaris/new
    def new
      @inventaris = Inventari.new
    end
  
    # GET /inventaris/1/edit
    def edit
    end
  
    # POST /inventaris
    def create
      @inventari = Inventari.new(inventari_params)
  
      if @inventari.save
        redirect_to @inventari, notice: 'inventari berhasil dibuat.'
      else
        render :new
      end
    end
    
  
    # PATCH/PUT /inventaris/1
    def update
      if @inventari.update(inventari_params)
        redirect_to @inventari, notice: 'inventari berhasil diperbarui.'
      else
        render :edit
      end
    end
  
    # DELETE /inventaris/1
    def destroy
      @inventari.destroy
      redirect_to inventaris_url, notice: 'inventari berhasil dihapus.'
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_inventari
        @inventari = Inventari.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def inventari_params
        params.require(:inventari).permit(:nama, :kepemilikan, :total)
      end
  end