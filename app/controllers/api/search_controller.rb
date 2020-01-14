class Api::SearchController < ApplicationController
  def search
    # 検索条件を取得
    search_params = search_params
    # TODO: Factory的な思想を入れてもいいかもしれない
    # 検索条件ごとにクラスを作るみたいな
    # 適用する検索条件を設定
    if search_params["search_location"].presense?
      #TODO: 都道府県で検索
    elsif search_params["search_arrival"].presense?
      # TODO: 所要時間で検索
    else
      # TODO: デフォルトの条件で検索
    end

    #TODO:ここに検索メソッド
    tour_spots = get_tour_spots(search_params["current_location"])
  end
  
  private

  def search_params
    # 検索する都道府県を取得(TODO:JSから現在地も取得する)
    params.require("search").permit([:search_arrival, :search_location, :current_location, :current_lag, :current_lat])
  end
end
