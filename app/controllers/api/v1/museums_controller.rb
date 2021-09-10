require "open-uri"

class Api::V1::MuseumsController < Api::V1::BaseController
  def search
    # Extract the params from request
    if params[:lat]
      lat = params[:lat]
    end
    if params[:lng]
      lng = params[:lng]
    end

    mapbox_request(lng, lat)
    render json: @museums.to_json
  end

  private

  def mapbox_request(lng, lat)
    # request museums from Mapbox for Lat & Long given by the user :
    mapbox_request = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?type=poi&proximity=#{lng},#{lat}&limit=10&access_token=#{ENV["MAPBOX_API_KEY"]}"
    mapbox_response_serialized = URI.open(mapbox_request).read
    @mapbox_response = JSON.parse(mapbox_response_serialized, object_class: OpenStruct)
    extract_wanted_infos
  end

  def extract_wanted_infos
    # Building Mapbox response throught wanted format
    @museums = {}
    @mapbox_response.features.each do |museum|
      list_of_museums_names = []
      postcode = ""

      # Extract postcode for each museum by finding to right element in museum.context array :
      museum.context.each do |element|
        postcode = element.text if element.id.include?("postcode")
      end

      # if postcode (as key of @museums) is already reference, add a new museum to the list:
      if @museums.key?(postcode)
        list_of_museums_names << @museums[postcode]
      end

      # For all, insert the name of the extract museum to a array used as value for postcode key :
      list_of_museums_names << museum.text
      # assigne or reasign key/value pair of postcode/museum(s) :
      @museums[postcode] = list_of_museums_names.flatten
    end
  end
end
