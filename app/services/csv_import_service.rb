require 'csv'

class CsvImportService
  def initialize(params)
    @csv_path = params[:path]
  end

  def upload
    playlist = humanize_csv @csv_path 
    
    playlist.each do |k, v|
      country = Country.get(k)
      country = country ? country : Country.create(name: k)

      country_list = v
      country_list.each do |year, list|
        country_play_list = CountryPlayList.get(country, year)
        if country_play_list != nil and not country_list.empty?
          country_play_list.destroy_all
        end
        list.each do |el|
          track = Track.get(el[1], el[0])
          if !track 
            author = Author.get(el[0])
            author = author ? author : Author.create(name: el[0])
            track = Track.create(name: el[1], cover: el[2],
              link: el[3], author: author) 
          end
          CountryPlayList.create(track: track, country: country, year: year)   
        end
      end
    end  
  end

  private
    def humanize_csv(path)
      csv_text = File.read(path)
      csv = CSV.parse(csv_text, :headers => false)
      countries = []
      csv.map{|key| countries << key[4]}
      playlist = {}
      countries.uniq.each do |country|
        years = []
        fields = csv.find_all {|row| row[4] == country}
        fields.map{|key| years << key[5]}
        yearlist = {}
        years.each do |year|
          yearlist[year] = fields.find_all {|row| row[5] == year}
        end
        playlist[country] = yearlist
      end
      playlist
    end
end