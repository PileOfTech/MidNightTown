class PacksController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def show
    @pack = Pack.find(params[:id])
  end

  def create
    if (params[:data][:name] and params[:data][:description] and params[:data][:file] and params[:genre_id]) 
      Pack.create(name: params[:data][:name], description: params[:data][:description], cover: params[:data][:file], genre_id: params[:genre_id])
      @res = {success: true, msg: 'Успешно загружено'}
      status_code = 200
    else
      @res = {success: false, msg: 'Не создано'}
      status_code = 400      
    end
    render json: @res, status: status_code
  end
  
  def inc_views
    image_id = params[:image_id]
    @image = Image.find(image_id)
    if !session["#{image_id}"]
      session["#{image_id}"] = true
      @image.increment!(:watches, by = 1)
    end
    @image
  end
end
