class HomeController < ApplicationController
  skip_before_action :authenticate!
  def index
    gon.BASE_URL = ENV['BASE_URL']
    gon.GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']
  end
end
