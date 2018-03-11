class ImagesController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def show
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    @res = {success: true, msg: 'Удалено'}
    status_code = 200
    render json: @res, status: status_code     
  end

end
