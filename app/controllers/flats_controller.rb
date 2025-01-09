class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @flats = Flat.where("name LIKE ? OR address LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @flats = Flat.all
    end
  end

  def show
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    if @flat.save
      redirect_to @flat, notice: 'Flat was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @flat.update(flat_params)
    redirect_to flat_path(@flat), notice: "Flat was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flat.destroy
    redirect_to flats_path(@flat), notice: "Flats was successfully deleted."
  end

  private

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:name, :address, :description, :number_of_guests, :price_per_night)
  end
end
