require 'rails_helper'

RSpec.describe 'ApiV1User', type: :request do
  include_context 'project setup'
  let(:town) { Town.find('33') }
  let(:headers) { { 'Authorization': "Bearer #{ user.token }" } }

  ####################################################################################

  describe 'POST /api/v1/user/create' do
    it 'アカウントが作成されていること' do
      old_user_cnt = User.all.size
      post api_v1_users_path, params: {
        user: {
          name: 'ARHM',
          email: 'thisisemail@gmail.com',
          password: 'password',
          password_confirmation: 'password',
          town_id: '33'
        }
      }

      users_cnt = User.all.size
      expect(response).to have_http_status(200)
      expect(users_cnt).to_not eq old_user_cnt
    end
  end

  ####################################################################################

  describe 'GET /api/v1/user/show/:id' do
    let(:email) { 'test@gmail.com' }
    let(:name) { 'test' }
    let(:user) { FactoryBot.create(:user, name: name, email: email, town: town) }

    it 'ユーザーデータが取得できている' do
      get api_v1_user_path(user), headers: headers

      data = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(data['user']['name']).to eq name
      expect(data['user']['email']).to eq email
      expect(data['user']['town_id']).to eq town.id
    end
  end

  ####################################################################################

  describe 'PUT /api/v1/user/update/:id' do
    let(:password) { 'password' }
    let(:email) { 'update@gmail.com' }
    let(:name) { 'update' }
    let(:town) { Town.find('10') }
    let(:user) { FactoryBot.create(:user, town: town) }

    ####################################################################################

    describe 'プロフィール編集' do
      it 'プロフィールが変更されていること' do
        put api_v1_user_path(user), params: {
          user: {
            name: name,
            town_id: town
          },
          auth: {
            is_authenticate: false,
            authenticate: ''
          }
        }, headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data['user']['name']).to_not eq name
        expect(data['user']['town_id']).to_not eq town.id
      end
    end

    ####################################################################################

    describe 'メールアドレス編集' do
      let(:user) do
        FactoryBot.create(
          :user,
          town: town,
          password: password,
          password_confirmation: password
        )
      end

      it 'メールアドレスが変更されていること' do
        put api_v1_user_path(user), params: {
          user: {
            email: email
          },
          auth: {
            is_authenticate: true,
            authenticate: password
          }
        }, headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data['user']['email']).to_not eq user.email
      end

      it '認証が失敗すること' do
        put api_v1_user_path(user), params: {
          user: {
            email: email
          },
          auth: {
            is_authenticate: true,
            authenticate: 'miss_authenticate'
          }
        }, headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data['result']).to eq 1
      end
    end

    ####################################################################################

    describe 'パスワード編集' do
      let(:user) do
        FactoryBot.create(
          :user,
          town: town,
          password: password,
          password_confirmation: password
        )
      end
      let(:new_password) { 'new_password' }
      it 'パスワードが変更されていること' do
        put api_v1_user_path(user), params: {
          user: {
            password: new_password,
            password_confirmation: new_password
          },
          auth: {
            is_authenticate: true,
            authenticate: password
          }
        }, headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data['result']).to eq 0
        expect(User.find(user.id).password_digest).to_not eq user.password_digest
      end
    end
  end

  ####################################################################################

  describe 'DELETE /api/v1/users/:id' do
    let(:user) { FactoryBot.create(:user, town: town) }
    let(:destination) { FactoryBot.create(:destination, user: user) }

    before { destination }
    it 'ユーザー情報が削除されていること' do
      delete api_v1_user_path(user), headers: headers

      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(data['result']).to eq 0
      expect { User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect { Destination.find(destination.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
