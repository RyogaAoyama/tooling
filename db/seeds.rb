# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

# 都道府県データ
require 'csv'
CSV.foreach('db/data/town.csv', headers: true) do |row|
  Town.create(
    town_id: row['town_id'],
    town_name: row['town_name']
  )
end

# 市区町村の位置データ
CSV.foreach('db/data/city.csv', headers: true) do |row|
  CityPlace.create(
    city_id: row['city_id'],
    town_id: row['town_id'],
    city_name: row['city_name'],
    lat: row['lat'],
    lng: row['lng']
  )
end

# ユーザーデータ
User.create(
  name: 'テストユーザー1',
  email: 'test@gmail.com',
  password: 'password123',
  password_confirmation: 'password123',
  authority: 1,
  town_id: '13'
)

20.times do |i|
  User.create(
    name: "テストユーザー#{ i + 1 }",
    email: "test#{ i + 1 }@gmail.com",
    password: "password#{ i + 1 }",
    password_confirmation: "password#{ i + 1 }",
    authority: 1,
    town_id: '13'
  )
end

users = User.all

users.each do |user|
  CSV.foreach('db/data/destinations.csv', headers: true) do |row|
    is_visit = rand(2) == 1
    now = is_visit ? DateTime.now : nil
    Destination.create(
      user_id: user.id,
      place_id: row['place_id'],
      name: row['name'],
      picture: row['picture'],
      address: row['address'],
      review_rank: row['review_rank'],
      review_num: row['review_num'],
      is_visit: is_visit,
      lat: row['lat'],
      lng: row['lng'],
      visited_at: now
    )
  end
end
