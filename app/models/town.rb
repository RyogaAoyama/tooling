class Town < ApplicationRecord
  has_many :city_places
  has_many :users
end
