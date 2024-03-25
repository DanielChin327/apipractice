class Api::V1::CafesController < ApplicationController

  # api/v1/cafes
  def index
    @cafes = Cafe.all
    if params[:title].present?
      @cafes = Cafe.where('title ILIKE ?', "%#{params[:title]}%")
    else
      @cafes = Cafe.all
    end
    # We don't render HTML
    # We want to render json
    render json:@cafes.order(created_at: :desc)
  end

  def create
    @cafe = Cafe.new(cafe_params)
    if @cafe.save
      render json: @cafe
    else
      render json: { error: @cafe.errors.messages }, status: :unprocessable_entity
    end
  end


  private

  def cafe_params
    params.require(:cafe).permit(:title, :address, :picture, :address, hours: {}, criteria: [])
  end
end
