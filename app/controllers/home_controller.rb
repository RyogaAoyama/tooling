class HomeController < ApplicationController
  def index
    gon.BASE_URL = ENV['BASE_URL']
  end
end
