class RestaurantsController < ApplicationController
  require "./app/models/restaurant.rb"
  def index
    respond_to do |format|
      format.json{
        response = Restaurant.get_details
        render json: (response["status"] ? response["data"] : "Something went wrong")
      }
      format.js{ render :js => "window.location = #{ root_path }" }
      format.html{ redirect_to root_path }
    end
  end
end
