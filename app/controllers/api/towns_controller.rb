class Api::TownsController < ApplicationController
  skip_before_action :authenticate!
  def index
    @towns = Town.order('town_id ASC')
  end
end
