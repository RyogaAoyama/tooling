require 'rails_helper'

RSpec.describe 'ApiSession', type: :request do
  let(:name) { 'test_user' }
  let(:password) { 'password' }
  let(:email) { 'test@gmail.com' }
  let(:user) do
    FactoryBot.create(
      :user,
      name: name,
      password: password,
      password_confirmation: password,
      email: email,
      town: town
    )
  end
  let(:town) { FactoryBot.create(:town) }
  let(:headers) { { 'Authorization': "Bearer #{ user.token }" } }

  describe 'POST /login' do
    it 'ユーザーデータが返却されていること' do
      post api_v1_login_path, params: {
        user: {
          email: user.email,
          password: password
        }
      }

      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(data['id']).to eq user.id
    end
  end

  describe 'DELETE /logout' do
    before do
      post api_v1_login_path, params: {
        user: {
          email: user.email,
          password: password
        }
      }
    end

    it 'セッションが削除されていること' do
      delete api_v1_logout_path, headers: headers
      expect(response).to have_http_status(200)
    end
  end
end
