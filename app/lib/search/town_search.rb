# 都道府県検索するクラス
class Search::TownSearch < Search::BaseSearch
  include Search::Common
  def search(params)
    # 市区町村を全て取得
    cities = CityPlace.where(town_id: params["town"])
    
    # ランダムで一つ選択
    city = cities[rand(cities.size)]

    # GoogleさんAPI用のクラス
    g_api = OuterApi::GoogleApi.new
    
    # 周辺検索
    query = {
      key: ENV["GOOGLE_API_KEY"],
      location: "#{city.lat},#{city.lng}",
      type: "tourist_attraction",
      radius: "5000",
      language: "ja"
    }
    is_success, status, data = g_api.place_search_exec(query)
    return status, data unless is_success
    places = data["results"]

    # 他の県が出ないように絞り込む
    town = Town.find_by(town_id: params["town"])
    places = town_refine(places, town.town_name)

    # 周辺検索の結果からランダムで一つ取得
    place = places[rand(places.size)]

    # 詳細を取得
    query = {
      key: ENV["GOOGLE_API_KEY"],
      place_id: place["place_id"],
      language: "ja"
    }
    is_success, status, data = g_api.place_detail_exec(query)
    return status, data unless is_success
    place_detail = data

    # 所要時間
    current_position = params["position"]
    destination = data["result"]["geometry"]["location"]
    query = {
      key: ENV["GOOGLE_API_KEY"],
      origins: "#{current_position["lat"]},#{current_position["lng"]}",
      destinations: "#{destination["lat"]},#{destination["lng"]}",
      language: "ja",
      avoid: "tolls"
    }

    # 所要時間をリクエスト
    is_success, status, data = g_api.distance_matrix_exec(query)
    return status, data unless is_success

    # 所要時間と詳細をマージ
    join_data = place_detail.merge(data)

    # ハッシュのネストをフラットにする
    join_data = flatten_hash(join_data)

    # 出力形式にフィールドをフォーマット
    join_data = field_format(join_data)

    # 定義されたフィールドのみ取得
    join_data = load_define_api_field(join_data: join_data)

    return status, join_data
  end
end