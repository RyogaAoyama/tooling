# 都道府県検索するクラス
class Search::TownSearch < Search::BaseSearch
  def search(params)
    # 市町村を全て取得
    cities = CityPlace.where(town_id: params["town"])
    
    # ランダムで一つ選択
    city = cities[rand(cities.size)]

    # リクエストデータの設定
    query = {
      key: ENV["GOOGLE_API_KEY"],
      location: "#{city.lat},#{city.lng}",
      type: "tourist_attraction",
      radius: "5000",
      language: "ja"
    }
    # GoogleさんAPI用のクラス
    g_api = OuterApi::GoogleApi.new

    ## 周辺検索の結果を取得 ##

    # 周辺検索の結果をリクエスト
    is_success, status, data = g_api.place_search_exec(query)
    return status, data unless is_success

    places = data["results"]

    # 他の県が出ないように絞り込む
    town = Town.find_by(town_id: params["town"])
    places = town_refine(places, town.town_name)

    # 周辺検索の結果からランダムで一つ取得
    place = places[rand(places.size)]

    ## ランダムで取得した地点の詳細を取得 ##

    # リクエストデータの設定
    query = {
      key: ENV["GOOGLE_API_KEY"],
      place_id: place["place_id"],
      language: "ja"
    }

    # 詳細結果をリクエスト
    is_success, status, data = g_api.place_detail_exec(query)
    return status, data unless is_success
    place_detail = data

    ## 所要時間を取得 ##

    # APIに送るパラメーターを設定
    current_position = params["position"]
    destination = data["result"]["geometry"]["location"]
    query = {
      key: ENV["GOOGLE_API_KEY"],
      origins: "#{current_position["lat"]},#{current_position["lng"]}",
      destinations: "#{destination["lat"]},#{destination["lng"]}",
      language: "ja",
    }
    data["avoid"] = tools if data["route"] == 0

    # 所要時間をリクエスト
    is_success, status, data = g_api.distance_matrix_exec(query)
    return status, data unless is_success

    # 所要時間と詳細をマージ
    join_data = place_detail.merge(data)

    # ハッシュのネストをフラットにする
    join_data = flatten_hash(join_data)

    # 定義されたフィールドのみ取得
    join_data = load_define_api_field(join_data)

    return status, join_data
  end


####################################################################################
  def town_refine(places, town_name)
    # 指定した県を表示するように検索結果を絞り込む
    places.select { |val| val["plus_code"]["compound_code"].include?(town_name) }
  end


####################################################################################
  def load_define_api_field(join_data)
    # フィールド定義を読み込み
    fields = FieldDefine::SEARCH_RESULT_FIELDS
    return_hash = {}

    # 定義にあるフィールドの値のみ抽出
    fields.each do |val|
      return_hash[val] = join_data[val] if join_data.key?(val)
    end
    return return_hash
  end


####################################################################################
  def flatten_hash(hash)
    hash.each_with_object({}) do |(key, val), return_val|
      next flatten_hash(val).each do |k, v|
        return_val[k] = v
      end if val.is_a?(Hash)
      return_val[key] = val
    end
  end
end