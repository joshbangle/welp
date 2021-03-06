class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def index
    @places = Place.order(:name).page(params[:page])
  end

  def create
    @place = current_user.places.create(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new
  end



  def edit
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render plain: "You cannot edit other people's places!", status: :forbidden
    end
  end

  def update
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render plain: "You cannot edit other people's places!", status: :forbidden
    end

    @place.update_attributes(place_params)

    if @place.valid?
      redirect_to place_path(params[:id]) #I wanted it to link back to the edited place, not to the full index. How else will the user see if their edit went through easily?
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render plain: "You cannot edit other people's places!", status: :forbidden
    end

    @place.destroy
    redirect_to root_path
  end


  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

end
