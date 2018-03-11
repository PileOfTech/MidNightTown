class PacksController < ApplicationController

  def show
    @pack = Pack.find(params[:id])
  end

  def download
    puts ">>>> #{params[:file]}"
    image =Image.new
    begin   
      image.image = params[:file]
      if image.save!
        @res = {success: true, msg: "File will be uploaded"}
        status_code = 200
      end
    rescue ActiveRecord::RecordInvalid
      @res = {success: false, msg: csv.errors.messages[:csv][0]}
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
