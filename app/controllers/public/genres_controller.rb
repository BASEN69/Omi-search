class Public::GenresController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]



  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @posts = @genre.posts.page(params[:page])
    
    @latitude = @genre.latitude
    @longitude = @genre.longitude
  end

end
