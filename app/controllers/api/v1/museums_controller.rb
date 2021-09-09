require "open-uri"

class Api::V1::MuseumsController < Api::V1::BaseController
  def search
    if params[:lat]
      lat = params[:lat]
    end
    if params[:lng]
      lng = params[:lng]
    end

    mapbox_request(lng, lat)
    render json: @museums.to_json
  end

  # def show
  # end

  private

  def mapbox_request(lng, lat)
    token = ENV['MAPBOX_API_KEY']
    request = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{lng},#{lat}&limit=10&access_token=#{token}"
    mapbox_response_serialized = URI.open(request).read
    @mapbox_response = JSON.parse(mapbox_response_serialized, object_class: OpenStruct)
    extract_wanted_infos

  end

  def extract_wanted_infos
    @museums = {}
    @mapbox_response.features.each do |museum|
      # binding.pry
      list_of_museums_names = []
      if @museums.key?(museum.context.first.text)
        list_of_museums_names << @museums[museum.context.first.text]
        # list_of_museums_names.flatten!
      end
      list_of_museums_names << museum.text
      @museums[museum.context.first.text] = list_of_museums_names.flatten
    end
  end
end
