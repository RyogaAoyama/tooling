module Api::GooggleMap
  extend ActiveSupport::Concern
  def get_tour_spots(location)
    search_query = "観光地"
    client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    spots = client.spots_by_query(search_query)
  end

  def match_arrival_time(spots)
    matrix = GoogleDistanceMatrix::Matrix.new
    spots.each do |value|
      # TODO: この中にspot検索の処理を入れる
      # 最初に一致したものを取得する
      # MatrixAPIで一気に距離算出できるかも？
    end
  end
end