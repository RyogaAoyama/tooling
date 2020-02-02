# 到着時間で検索するためのクラス
class Search::ArrivalSearch < Search::BaseSearch
  include Search::Common
  def search(params)
    g_api = OuterApi::GoogleApi.new

    # 都道府県名を取得
    town_name = get_address(params[:position], g_api)

    # 都道府県コードを取得
    town_id = Town.find_by(town_name: town_name).town_id

    # 市区町村を取得
    current_cities = CityPlace.where(town_id: town_id)

    # 市区町村の経緯度をAPIのパラメーター用に整形(緯度,経度|緯度,経度|緯度,経度みたいな形式)
    positions = current_cities.map do |val|
      "#{val[:lat]},#{(val[:lng])}"
    end
    destinations = positions.join("|")

    # distance matrix APIで現在地から全ての市区町村までの所要時間を取得
    query = {
      key: ENV["GOOGLE_API_KEY"],
      language: "ja",
      origins: "#{params[:position][:lat]},#{params[:position][:lng]}",
      destinations: destinations,
      avoid: "tolls"
    }
    is_success, status, res = g_api.distance_matrix_exec(query)
    return status, data unless is_success

    # 所要時間の条件に合致する市区町村を抽出
    success_cities = city_refine(params[:arrivalTime], res, current_cities)
    return 200, load_define_api_field() if success_cities.size == 0

    # 所要時間の条件に合致した市区町村の中からランダムで一つ取得
    city = success_cities[rand(success_cities.size)]

    # ランダムで選択した市区町村を周辺検索
    query = {
      key: ENV["GOOGLE_API_KEY"],
      location: "#{city[:lat]},#{city[:lng]}",
      type: "tourist_attraction",
      radius: "5000",
      language: "ja"
    }
    is_success, status, data = g_api.place_search_exec(query)
    return status, data unless is_success

    # 他の県が出ないように絞り込む
    places = town_refine(data["results"], town_name)

    # 周辺検索の結果からランダムで一つ取得
    place = places[rand(places.size)]

    # 詳細検索
    query = {
      key: ENV["GOOGLE_API_KEY"],
      place_id: place["place_id"],
      language: "ja"
    }
    is_success, status, data = g_api.place_detail_exec(query)
    return status, data unless is_success
    place_detail = data

    # 所要時間を取得
    current_position = params["position"]
    destination = place_detail["result"]["geometry"]["location"]
    query = {
      key: ENV["GOOGLE_API_KEY"],
      origins: "#{current_position["lat"]},#{current_position["lng"]}",
      destinations: "#{destination["lat"]},#{destination["lng"]}",
      language: "ja",
      avoid: "tolls"
    }
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

  # 所要時間内の市区町村を取得する
  def city_refine(arrival_time, distances, cities)
    rtn_cities = []
    distances["rows"][0]["elements"].each_with_index do |val, idx|
      diff = arrival_time - val["duration"]["value"]
      if diff > -1200 && diff < 1200
        rtn_cities << { lat: cities[idx][:lat], lng: cities[idx][:lng] }
      end
    end
    return rtn_cities
  end
end