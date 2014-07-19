class HomeController < ApplicationController
	before_filter :authenticate_user_from_token!

  def index
  end
end
