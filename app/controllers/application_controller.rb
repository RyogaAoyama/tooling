class ApplicationController < ActionController::Base
  # TODO: CSRF対策無効(本番では必ず消すこと！！！！)
  skip_before_action :verify_authenticity_token
  before_action :authenticate!

  def authenticate!
    authenticate_or_request_with_http_token do |token|
      User.find_by(token: token).present?
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:id]) if session[:id]
  end
end
