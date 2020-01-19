class Api::SearchController < ApplicationController
  def search
    # 検索条件を取得
    # TODO: もしtownが空白だったらユーザー設定した時の都道府県を使用


    # 適用する検索条件を設定
    if search_params["town"].present?
      # 都道府県で検索
      search_obj = Search::TownSearch.new
    elsif search_params["arrivalTime"].present?
      # 所要時間で検索
      search_obj = Search::ArrivalSearch.new
    else
      # デフォルトの条件で検索
      search_obj = Search::DefaultSearch.new
    end

    # 検索
    status, @result = search_obj.search(search_params)
    p @result

    # 値を返却
    render :search, status: status
  end
  
  private

  def search_params
    params.require("search").permit([
      :arrivalTime,
      :town,
      :route, 
      position: [ :lat, :lng ]
    ])
  end
end
