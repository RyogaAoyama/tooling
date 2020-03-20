# 行き先の情報を全て取得するためのクラス
class Search::FullData
  include Search::Common
  def get_full_data(position, place_id)
    g_api = OuterApi::GoogleApi.new

    # 詳細検索
    query = {
      key: ENV['GOOGLE_API_KEY'],
      place_id: place_id,
      language: 'ja'
    }
    is_success, status, data = g_api.place_detail_exec(query)
    return status, data unless is_success

    place_detail = data

    full_data = {}
    # 現在地が取得できなかった場合は所要時間は取得しない
    if position.key?('lat')
      # 所要時間を取得
      destination = place_detail['result']['geometry']['location']
      query = {
        key: ENV['GOOGLE_API_KEY'],
        origins: "#{ position['lat'] },#{ position['lng'] }",
        destinations: "#{ destination['lat'] },#{ destination['lng'] }",
        language: 'ja',
        avoid: 'tolls'
      }
      is_success, status, data = g_api.distance_matrix_exec(query)
      return status, data unless is_success

      # 所要時間と詳細をマージ
      full_data = place_detail.merge(data)
    else
      full_data = place_detail
    end

    # ハッシュのネストをフラットにする
    full_data = flatten_hash(full_data)

    # 出力形式にフィールドをフォーマット
    full_data = field_format(full_data)

    # 定義されたフィールドのみ取得
    full_data = load_define_api_field(join_data: full_data)

    [status, full_data]
  end
end
