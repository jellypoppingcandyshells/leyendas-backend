class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :null_session

	respond_to :json

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
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Unauthorized', status: 401
  end
end
