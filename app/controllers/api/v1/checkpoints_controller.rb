class Api::V1::CheckpointsController < ApplicationController
	before_filter :authenticate

	def index
		render json: Checkpoint.all
	end
	def show
		render json: Checkpoint.find(params[:id])
	end
	def create
		checkpoint = Checkpoint.new(checkpoint_params)
		if checkpoint.save
			render json: checkpoint
		else
			render json: {message: 'Something went wrong', errors: checkpoint.errors, errors_full_messages: checkpoint.errors.full_messages}
			end
	end
	def update
		checkpoint = Checkpoint.find(params[:id])
		checkpoint.update_attributes(checkpoint_params)
		render json: checkpoint
	end
	def destroy
		checkpoint = Checkpoint.find(params[:id])
		checkpoint.destroy
		head :no_content
	end


	private
	def checkpoint_params
		params.require(:checkpoint).permit(:name)
	end
end