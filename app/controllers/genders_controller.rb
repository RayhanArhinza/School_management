
class GendersController < ApplicationController
    before_action :set_gender, only: %i[show edit update destroy]
  
    def index
      @genders = Gender.all
    end
  
    def show
    end
  
    def new
      @gender = Gender.new
    end
  
    def create
      @gender = Gender.new(gender_params)
      if @gender.save
        redirect_to @gender, notice: "Gender was successfully created."
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @gender.update(gender_params)
        redirect_to @gender, notice: "Gender was successfully updated."
      else
        render :edit
      end
    end
  
    def destroy
      @gender.destroy
      redirect_to genders_url, notice: "Gender was successfully destroyed."
    end
  
    private
  
    def set_gender
      @gender = Gender.find(params[:id])
    end
  
    def gender_params
      params.require(:gender).permit(:name)
    end
  end