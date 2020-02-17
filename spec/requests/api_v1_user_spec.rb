require 'rails_helper'

RSpec.describe 'ApiV1User', type: :request do
  include_context "project setup"
  let(:headers) do
    { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  describe "POST /api/v1/user/create" do
    it "アカウントが作成されていること" do
      old_user_cnt = User.all.size
      post api_v1_users_path, params: {
        user: {
          name: "ARHM",
          email: "thisisemail@gmail.com",
          password: "password",
          password_confirmation: "password",
          town_id: "33"
        }
      }

      users_cnt = User.all.size
      expect(response).to have_http_status(200)
      expect(users_cnt).to_not eq old_user_cnt
    end
  end

  describe "GET /api/v1/user/show/:id" do
    let(:town) { Town.find("33") }
    let(:user) { FactoryBot.create(:user, name: "test", email: "test@gmail.com", town: town) }

    it "ユーザーデータが取得できている" do
      get api_v1_user_path(user), headers: headers

      data = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(data["name"]).to eq "test"
      expect(data["email"]).to eq "test@gmail.com"
      expect(data["town_id"]).to eq "33"
    end
  end

  describe "PUT /api/v1/user/update/:id" do
    let(:user) { FactoryBot.create(:user, password: "password") }
    describe "プロフィール編集" do
      it "プロフィールが変更されていること" do
        # TODO: S3のパス
        put api_v1_user(user), params: {
          user: {
            name: "update_name",
            email: user.email,
            town_id: "10",
            avatar: "S3のパス",
            is_authenticate: false
          }
        },
        headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data["name"]).to_not eq user.name
        expect(data["town_id"]).to_not eq user.town_id
      end

      # TODO: 写真はどうすればいいかわからんから実装してから書く
      it "写真が変更されていること"

    end

    describe "メールアドレス編集" do
      it "メールアドレスが変更されていること" do
        put api_v1_user(user), params: {
          user: {
            name: user.name,
            email: "update_email@gmail.com",
            password: "password",
            town_id: user.town_id,
            avatar: user.avatar,
            is_authenticate: true
          }
        },
        headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data["email"]).to_not eq user.email
      end

      it "認証が失敗すること" do
        put api_v1_user(user), params: {
          user: {
            name: user.name,
            email: "update_email@gmail.com",
            password: "miss_password",
            town_id: user.town_id,
            avatar: user.avatar,
            is_authenticate: true
          }
        },
        headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data["resuslt"]).to be_falsey
      end
    end

    describe "パスワード編集" do
      it "パスワードが変更されていること" do
        put api_v1_user(user), params: {
          user: {
            name: user.name,
            email: user.email,
            authenticate: "password",
            password: "update_password",
            password_confirmation: "update_password",
            town_id: user.town_id,
            avatar: user.avatar,
            is_authenticate: true
          }
        },
        headers: headers

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data["resuslt"]).to be_falsey
      end
      it "認証が失敗すること" do
        put api_v1_user(user), params: {
          user: {
            name: user.name,
            email: user.email,
            authenticate: "miss_password",
            password: "password",
            password_confirmation: "password",
            town_id: user.town_id,
            avatar: user.avatar,
            is_authenticate: true
          }
        },
        headers: headers

        data = JSON.parse(response.body)
        new_password_digest = User.find(user.id).password_digest

        expect(response).to have_http_status(200)
        expect(new_password_digest).to_not user.password_digest
      end
    end
  end

  describe "DELETE /api/v1/user/delete/:id" do
    it "ユーザー情報が削除されていること" do
      delete api_v1_user(user), headers: headers

      expect(response).to have_http_status(200)
      expect{ User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    # TODO: これは関連する機能を追加したときに作成
    it "ユーザーに関連する情報が削除されていること"
  end
end