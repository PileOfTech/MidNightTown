class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @packs = @genre.packs
  end

  def create
    puts "#{params[:file]}"
    
  end
  
  def price_list
    render :price_list
  end

  def contacts
    render :contacts
  end

end
