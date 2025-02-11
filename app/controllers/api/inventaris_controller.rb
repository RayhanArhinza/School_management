module API
class Api::InventarisController < ApplicationController
    before_action :set_inventari, only: [:show, :update, :destroy]

    # GET /api/inventaris
    def index
      @inventaris = Inventari.all
      render json: @inventaris
    end

    # GET /api/inventaris/:id
    def show
      render json: @inventari
    end

    # POST /api/inventaris
    def create
      @inventari = Inventari.new(inventari_params)
      if @inventari.save
        render json: @inventari, status: :created
      else
        render json: @inventari.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/inventaris/:id
    def update
      if @inventari.update(inventari_params)
        render json: @inventari
      else
        render json: @inventari.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/inventaris/:id
    def destroy
      @inventari.destroy
      head :no_content
    end

    private

    def set_inventari
      @inventari = Inventari.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Inventaris tidak ditemukan" }, status: :not_found
    end

    def inventari_params
      params.require(:inventari).permit(:nama, :kepemilikan, :total)
    end
  end
end
