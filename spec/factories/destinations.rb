FactoryBot.define do
  factory :destination do
    review_rank { '9.99' }
    review_num { 1 }
    visited_at { '2020-02-29 08:16:43' }
    lat { '9.99' }
    lng { '9.99' }
    sequence(:place_id) { |i| "MyString#{ i }" }
    sequence(:name) { |i| "MyString#{ i }" }
    sequence(:picture) { |i| "MyString#{ i }" }
    sequence(:address) { |i| "MyString#{ i }" }
  end
end
