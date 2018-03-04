class CountryPlayListController < ApplicationController
  before_action :set_country_playlist, only: [:show]

  def index
    @playlists = CountryPlayList.where(country: Country.get(params[:country]), 
      year: params[:year])
  end

  private
    def set_country_playlist
      @playlists = CountryPlayList.where(country: Country.get(params[:country]),
       year: params[:year])
    end
end
