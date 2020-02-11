FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "テストユーザー#{i}" }
    sequence(:email) { |i| "thisismail#{i}@gmail.com" }
    sequence(:password_digest) { |i| "password#{i}" }
    live_town { 33 }
    # TODO: avatar
  end
end
