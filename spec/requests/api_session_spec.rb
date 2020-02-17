require 'rails_helper'

RSpec.describe 'ApiSession', type: :request do
  let(:name) { "test_user" }

  before do
    post api_v1_users_path, params: {
      user: {
        name: name,
        email: "test@gmail.com",
        password: "password",
        password_confirmation: "password",
        town_id: "33"
      }
    }
  end

  describe "POST /session" do
    
    it "ユーザーデータが返却されていること" do
      post api_v1_sessions_path, params: {
        user: {
          email: "test@gmail.com",
          password: "password"
        }
      }
      
      data = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(data[:name]).to eq name
    end

    describe "DELETE /session" do

      before do
        post api_v1_sessions_path, params: {
          user: {
            email: "test@gmail.com",
            password: "password"
          }
        }
      end
      
      it "セッションが削除されていること" do
        delete api_v1_session_path, headers: headers
        expect(response).to have_http_status(200)
      end
    end
  end
end