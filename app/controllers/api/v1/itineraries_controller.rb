class Api::V1::ItinerariesController < ApplicationController
	before_filter :authenticate

	def index
		render json: Itinerary.all
	end
	def show
		render json: Itinerary.find(params[:id])
	end
	def create
		itinerary = Itinerary.new(itinerary_params)
		if itinerary.save
			render json: itinerary
		else
			render json: {message: 'Something went wrong', errors: itinerary.errors, errors_full_messages: itinerary.errors.full_messages}
		end
	end
	def update
		itinerary = Itinerary.find(params[:id])
		itinerary.update_attributes(itinerary_params)
		render json: itinerary
	end
	def destroy
		itinerary = Itinerary.find(params[:id])
		itinerary.destroy
		head :no_content
	end


	private
	def itinerary_params
		params.require(:itinerary).permit(:name)
	end

end