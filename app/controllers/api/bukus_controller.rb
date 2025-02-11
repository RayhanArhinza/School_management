module API
    class Api::BukusController < ApplicationController
        before_action :set_buku, only: [:show, :update, :destroy]
    
        # GET /api/inventaris
        def index
          @Bukus = Buku.all
          render json: @Bukus
        end
    
        # GET /api/Bukus/:id
        def show
          render json: @buku
        end
    
        # POST /api/Bukus
        def create
          @buku = buku.new(buku_params)
          if @buku.save
            render json: @buku, status: :created
          else
            render json: @buku.errors, status: :unprocessable_entity
          end
        end
    
        # PATCH/PUT /api/Bukus/:id
        def update
          if @buku.update(buku_params)
            render json: @buku
          else
            render json: @buku.errors, status: :unprocessable_entity
          end
        end
    
        # DELETE /api/Bukus/:id
        def destroy
          @buku.destroy
          head :no_content
        end
    
        private
    
        def set_buku
          @buku = Buku.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { error: "Bukus tidak ditemukan" }, status: :not_found
        end
    
        def inventari_params
          params.require(:Buku).permit(:judul, :isbn, :pengarang, :penerbit, :tahun_terbit, :category)
        end
      end
    end
    