class Api::SearchController < ApplicationController
  def search
    # 到着時間で検索
    search_obj = if search_params['arrivalTime'].present?
                   Search::ArrivalSearch.new
                 # 都道府県で検索(何も選択されていなかった場合も都道府県で検索)
                 else
                   Search::TownSearch.new
                end

    # 検索
    status, @result = search_obj.search(search_params)

    # 値を返却
    render :search, status: status
  end

  private

  def search_params
    params.require('search').permit([
                                      :arrivalTime,
                                      :town,
                                      position: %i[lat lng]
                                    ])
  end
end
