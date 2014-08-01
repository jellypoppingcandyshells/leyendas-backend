class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	respond_to :json

    rescue_from ActionController::ParameterMissing, with: :rescue_from_parameter_missing
    rescue_from ActiveRecord::RecordInvalid, with: :rescue_from_record_invalid
    # rescue_from Exception, with: :rescue_with_errors

    private
    # http://blog.envylabs.com/post/75521798481/token-based-authentication-in-rails
    def authenticate
        authenticate_token || render_unauthorized
    end
    def authenticate_token
        authenticate_with_http_token do |token, options|
          user = User.find_by_authentication_token(token.to_s)
          if user
            sign_in user, store: false
          end
        end
    end
    def render_unauthorized
        # self.headers['WWW-Authenticate'] = 'Token realm="Application"'
        render json: 'Unauthorized', status: 401
    end
    def rescue_from_parameter_missing(e)
        render json: {success: false, messages: [e.message]}, status: :unprocessable_entity
    end
    def rescue_from_record_invalid(e)
        render json: {success: false, messages: [e.message]}, status: :unprocessable_entity
    end
    def rescue_with_errors(e)
        render json: {success: false, messages: [e.message]}, status: :internal_server_error
    end
end
