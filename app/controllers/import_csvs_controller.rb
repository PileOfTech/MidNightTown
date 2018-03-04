class ImportCsvsController < ApplicationController
  require 'csv'

  def import
    csv = ImportCsv.new
    begin   
      csv.csv = params[:file]
      if csv.save!
        CsvImportService.new({path: csv.csv.path}).upload
        @res = {success: true, msg: "File will be uploaded"}
        status_code = 200
      end
    rescue ActiveRecord::RecordInvalid
      @res = {success: false, msg: csv.errors.messages[:csv][0]}
      status_code = 400
    end  
    render json: @res, status: status_code    
  end

end
