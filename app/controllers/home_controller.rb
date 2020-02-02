class HomeController < ApplicationController
  def index
    gon.BASE_URL = ENV['BASE_URL']
    gon.GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']
  end
end
