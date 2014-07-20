class Api::V1::CheckpointsController < ApplicationController
	before_filter :authenticate, except: [:create]
	
	Checkpoint = Struct.new(:id, :name, :location)

	def index

		@checkpoints = [
			Checkpoint.new(1, 'MarBella', 'Barcelona, Spain'),
			Checkpoint.new(2, 'Roc', 'El Vendrell, Spain')
		]
		
		render json: @checkpoints
	end

end