require 'rails_helper'

RSpec.describe 'ApiSearch', type: :request do
  POSITION = { lat: 34.6480862, lng: 133.8974896 }.freeze
  TOWN = '33'.freeze # 岡山
  ARRAIVAL_TIME = 3600

  include_context 'project setup'

  let(:town) { Town.find('33') }
  let(:user) { FactoryBot.create(:user, town: town) }
  let(:headers) { { 'Authorization': "Bearer #{ user.token }" } }

  describe 'GET /search' do
    fields = FieldDefine::SEARCH_RESULT_FIELDS

    context '到着時間で検索する場合' do
      it '全てのフィールドを取得できていること' do
        post api_search_path, params: {
          search: {
            arrivalTime: ARRAIVAL_TIME,
            town: '',
            position: POSITION
          }
        }, headers: headers

        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(data['result'].size).to eq fields.size
      end
    end

    context '都道府県で検索する場合' do
      it '全てのフィールドを取得できていること' do
        post api_search_path, params: {
          search: {
            arrivalTime: '',
            town: TOWN,
            position: POSITION
          }
        }, headers: headers

        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(data['result'].size).to eq fields.size
      end
    end
  end
end
