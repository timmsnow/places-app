class Api::PlacesController < ApplicationController
  def index
    @places = Place.all
    render "index.json.jb"
  end

  def create
    @place = Place.new(
      name: params[:name],
      address: params[:address],
    )

    #happy/sad
    if @place.save
      render "show.json.jb"
    else
      render json: { error: @place.errors.full_messages }, status: 400
    end
  end

  def show
    place_id = params[:id]
    @place = Place.find(place_id)
    render "show.json.jb"
  end

  def update
    @place = Place.find(params[:id])
    @place.name = params[:name] || @place.name
    @place.address = params[:address] || @place.address

    #happy/sad
    if @place.save
      render "show.json.jb"
    else
      render json: { error: @place.errors.full_messages }, status: 400
    end
  end

  def destroy
    place_id = params[:id]
    @place = Place.find(place_id)
    @place.destroy
    render json: { message: "Place destroyed" }
  end
end
