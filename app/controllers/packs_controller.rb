class PacksController < ApplicationController

  def show
    @pack = Pack.find(params[:id])
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
