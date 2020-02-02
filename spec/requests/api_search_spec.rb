require 'rails_helper'
require "csv"

RSpec.describe 'ApiSearch', type: :request do
  POSITION = { lat: 34.6480862, lng: 133.8974896 }
  TOWN = "33" # 岡山
  ARRAIVAL_TIME = 3600

  include_context "project setup"

  describe "GET /search" do

    fields = FieldDefine::SEARCH_RESULT_FIELDS

    context "到着時間で検索する場合" do
      it "全てのフィールドを取得できていること" do
        post api_search_path, params: {
          search: {
            arrivalTime: ARRAIVAL_TIME,
            town: "",
            position: POSITION
          }
        },
        as: :json

        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(data["result"].size).to eq fields.size
      end
    end

    context "都道府県で検索する場合" do
      it "全てのフィールドを取得できていること" do
        post api_search_path, params: {
          search: {
            arrivalTime: "",
            town: TOWN,
            position: POSITION
          }
        },
        as: :json

        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(data["result"].size).to eq fields.size
      end
    end
  end
end