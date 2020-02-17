class ApplicationController < ActionController::Base
  # TODO: CSRF対策無効(本番では必ず消すこと！！！！)
  skip_before_action :verify_authenticity_token
end
