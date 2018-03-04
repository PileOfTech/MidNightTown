class CountriesController < ApplicationController
  before_action :set_country, only: [:show]

  # GET /countries
  # GET /countries.json
  def index
    @countries = Country.all
  end

  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @playlist = Country.find(params[:id])
    end
end
