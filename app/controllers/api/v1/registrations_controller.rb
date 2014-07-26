class Api::V1::RegistrationsController < ApplicationController

	# POST /api/v1/registrations
	def create
		user = User.new(registration_params)
		if user.save
			sign_in user
			render json: {success: true, message: 'Signed Up!', authentication_token: user.authentication_token}
		else
			render json: {success: false, message: 'Something is wrong', errors: user.errors, errors_full_messages: user.errors.full_messages}, status: 422
		end
	end

	private
	def registration_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end
