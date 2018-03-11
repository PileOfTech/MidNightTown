class GenresController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def index
    @genres = Genre.all.order(created_at: :desc)
  end

  def show
    @genre = Genre.find(params[:id])
    @packs = @genre.packs.order(created_at: :asc)
  end

  def create
    if (params[:name] and params[:file])
      Genre.create(name: params[:name], cover: params[:file])
      @res = {success: true, msg: 'Успешно загружено'}
      status_code = 200
    else
      @res = {success: false, msg: 'Не создано'}
      status_code = 400      
    end
    render json: @res, status: status_code 
  end
  
  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    @res = {success: true, msg: 'Удалено'}
    status_code = 200
    render json: @res, status: status_code 
  end

  def price_list
    render :price_list
  end

  def contacts
    render :contacts
  end

end
