class Api::TownsController < ApplicationController
  def index
    @towns = Town.order("town_id ASC")
  end
end
