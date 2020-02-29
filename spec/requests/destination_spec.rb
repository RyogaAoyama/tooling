require 'rails_helper'

RSpec.describe 'ApiV1User', type: :request do
  include_context 'project setup'
  let(:town) { Town.find('33') }
  let(:user) { FactoryBot.create(:user, town: town) }
  let(:headers) { { 'Authorization': user.token } }
  let(:destination) { Destination.all.first }

  before do
    10.times do
      FactoryBot.create(:destination, user: user)
    end
  end

  describe 'GET /api/v1/users/:id/destinations' do
    context 'フィールドが指定されている場合' do
      let(:fields) { { fields: 'name' } }

      it '指定されているフィールドのみ取得されていること' do
        get api_v1_user_destinations_path(user, fields), headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data[0].keys.size).to eq 1
        expect(data[0].keys[0]).to eq fields.values[0]
      end
    end

    context 'フィールドが指定されていない場合' do
      it '全てのフィールドが取得できていること' do
        get api_v1_user_destinations_path(user)

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        # TODO: output_columnで返却するカラムを設定するのでこのサイズを指定すればテストできる
        expect(data[0].keys.size).to eq Destination.output_column.size
      end
      it 'ユーザーの全ての行き先レコードが取得できていること' do
        get api_v1_user_destinations_path(user), headers: headers

        data = JSON.parse(response.body)

        expect(response).to eq have_http_status(200)
        expect(data.size).to eq user.destinations.size
      end
    end

    context '不明なフィールドが指定されていた場合' do
      let(:fields) { { fields: 'error' } }
      it '401 Unauthorizedを返却' do
        get api_v1_user_destinations_path(user, fields), headers: headers

        expect(response).to eq have_http_status(401)
      end
    end
  end

  ####################################################################################

  describe 'GET /api/v1/users/:id/destinations/:id' do
    context 'フィールドが指定されている場合' do
      let(:fields) { { fields: 'name' } }

      it '指定されているフィールドのみ取得されていること' do
        get api_v1_user_destinations_path(user, fields), headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data[0].keys.size).to eq 1
        expect(data[0].keys[0]).to eq fields.values[0]
      end
    end

    context 'フィールドが指定されていない場合' do
      it '全てのフィールドが取得できていること' do
        get api_v1_user_destinations_path(user), headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data[0].keys.size).to eq Destination.output_column.size
      end
    end

    context '不明なフィールドが指定されていた場合' do
      let(:fields) { { fields: 'error' } }
      it '401 Unauthorizedを返却' do
        get api_v1_user_destinations_path(user, fields), headers: headers

        expect(response).to eq have_http_status(401)
      end
    end
  end

  ####################################################################################

  describe 'POST api/v1/users/:id/destinations' do
    it '行き先が保存されていること' do
      old_destination_cnt = user.destinations.size
      post api_v1_user_destinations_path(user), params: {
        place_id: 'test_place',
        name: 'test_name',
        picture: 'test_picture',
        address: 'test_address',
        review_rank: 'test_review',
        review_num: 'test_review',
        lat: 12.1111111,
        lng: 123.5555555
      }, headers: headers

      expect(response).to have_http_status(201)
      expect(user.destinations.size).to_not eq old_destination_cnt
    end
  end

  ####################################################################################

  describe 'DELETE api/v1/users/:user_id/destinations/:id' do
    it '行き先が削除されていること' do
      delete api_v1_user_destination_path(user, destination), headers: headers

      expect(response).to have_http_status(204)
      expect { Destination.find(destination.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  ####################################################################################

  describe 'PUT api/v1/users/:user_id/destinations/:id' do
    context 'is_visitがtrueに更新される場合' do
      # TODO: visited_atがどんな値になってるのか予想つかないから実装したあと
      it 'is_visitとvisited_atが更新されている' do
        put api_v1_user_destination_path(user, destination), params: {
          is_visit: true
        }, headers: headers

        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(data['is_visit']).to be_truthy
      end
    end

    context 'is_visitがfalseに更新されるとき' do
      # TODO: visited_atがどんな値になってるのか予想つかないから実装したあと
      it 'is_visitとvisited_at(デフォルト値に)が更新されている' do
        put api_v1_user_destination_path(user, destination), params: {
          is_visit: true
        }, headers: headers

        data = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(data['is_visit']).to be_falsay
      end
    end
  end
end
