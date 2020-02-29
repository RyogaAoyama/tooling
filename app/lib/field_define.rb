class FieldDefine
  # 行き先検索で使用するフィールドリスト
  SEARCH_RESULT_FIELDS = %w[
    lat
    lng
    icon
    name
    place_id
    formatted_phone_number
    rating
    reference
    reviews
    address_number
    address
    origin_addresses
    rows
    photos
    user_ratings_total
  ].freeze
end
