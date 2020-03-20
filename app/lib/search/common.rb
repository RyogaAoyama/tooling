# 検索に使用するメソッドがあるモジュール
module Search::Common
  ####################################################################################

  # 経緯度から都道府県を取得する
  def get_address(position, g_api)
    p ENV['GOOGLE_API_KEY']
    query = {
      language: 'ja',
      sensor: false,
      key: ENV['GOOGLE_API_KEY'],
      latlng: "#{ position[:lat] },#{ position[:lng] }"
    }
    is_success, status, res = g_api.google_map_exec(query)
    /(.*)、(〒[0-9]{3}-[0-9]{4}) (.*県)(.*)/ =~ res['results'][0]['formatted_address']
    Regexp.last_match(3)
  end

  ####################################################################################

  # 出力形式をフォーマットする
  def field_format(join_data)
    # 住所フォーマット
    /(.*)、(〒[0-9]{3}-[0-9]{4}) (.*)/ =~ join_data['formatted_address']
    join_data['address_number'] = Regexp.last_match(2)
    join_data['address'] = Regexp.last_match(3)

    photo_limit = 7
    # 写真を7件のみ取得するように制限
    if join_data['photos']
      join_data['photos'].slice!(photo_limit, join_data['photos'].size) if join_data['photos'].size > photo_limit
    end
    join_data
  end

  ####################################################################################

  # 指定した県を表示するように検索結果を絞り込む
  def town_refine(places, town_name)
    places.select { |val| val['plus_code']['compound_code'].include?(town_name) }
  end

  ####################################################################################

  # フィールド定義してある値のみ取得する
  def load_define_api_field(join_data: {})
    # フィールド定義を読み込み
    fields = FieldDefine::SEARCH_RESULT_FIELDS
    return_hash = {}

    # 定義にあるフィールドの値のみ抽出
    fields.each do |val|
      return_hash[val] = if join_data.key?(val)
                           join_data[val]
                         else
                           ''
                        end
    end
    return_hash
  end

  ####################################################################################

  # ハッシュをフラットにする
  def flatten_hash(hash)
    hash.each_with_object({}) do |(key, val), return_val|
      if val.is_a?(Hash)
        next flatten_hash(val).each do |k, v|
          return_val[k] = v
        end
      end
      return_val[key] = val
    end
  end
end
