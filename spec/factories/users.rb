FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "テストユーザー#{i}" }
    sequence(:email) { |i| "thisismail#{i}@gmail.com" }
    sequence(:password) { |i| "password#{i}" }
    
  end
end
