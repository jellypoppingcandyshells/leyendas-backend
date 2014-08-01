class Api::V1::SessionsController < ApplicationController

	before_filter :authenticate, except: [:create]
	# before_filter :authenticate_user_from_token! #, except: [:create]
	# before_action :authenticate_user!, except: [:create]

	include Devise::Controllers::Helpers

	# POST /api/v1/sessions
	def create
		resource = User.find_for_database_authentication(email: session_params[:email])

		if resource.nil?
			render json: {success: false, message: 'Could not find user'}, status: 401
		else
			if resource.valid_password?(session_params[:password])
				sign_in('user', resource)
				
				resource.regenerate_authentication_token
				resource.save
				resource.ensure_authentication_token
				
				render json: {success: true, message: 'You are in!', authentication_token: resource.authentication_token}
			else
				render json: {success: false, message: 'Wrong password'}, status: 401
			end
		end
	rescue Exception => e
		render json: {success: false, message: e.message}, status: 401
	end

	protected
	def session_params
		params.require(:user).permit(:email, :password)
	end
end
