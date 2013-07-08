class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new

  end

  def create
    @artist = Artist.create(params[:artist])
    if @artist.save
      redirect_to artists_path
    else
      redirect_to new_artist_path
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update_attributes(params[:artist])
      redirect_to artist_path
    else
    	@artist.reload
      redirect_to edit_artist_path
    end
  end

  def destroy
    @artist = Artist.find(params[:id]).destroy
		redirect_to artists_path

  end
end
