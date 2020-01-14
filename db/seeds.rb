# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 都道府県データ
require "csv"
CSV.foreach("db/data/town.csv", headers: true) do |row|
  Town.create(
    town_id: row["town_id"],
    town_name: row["town_name"]
  )
end

# 市区町村の位置データ
CSV.foreach("db/data/city.csv", headers: true) do |row|
  CityPlace.create(
    city_id: row["city_id"],
    town_id: row["town_id"],
    city_name: row["city_name"],
    lat: row["lat"],
    lng: row["lng"]
 )
end