require 'rails_helper'

RSpec.describe 'ApiV1User', type: :request do
  include_context "project setup"
  let(:town) { Town.find("33") }

  ####################################################################################

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

  ####################################################################################

  describe "GET /api/v1/user/show/:id" do
    let(:email) { "test@gmail.com" }
    let(:name) { "test" }
    let(:user) { FactoryBot.create(:user, name: name, email: email, town: town) }

    it "ユーザーデータが取得できている" do
      get api_v1_user_path(user)

      data = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(data["user"]["name"]).to eq name
      expect(data["user"]["email"]).to eq email
      expect(data["user"]["town_id"]).to eq town.id
    end
  end

  ####################################################################################

  describe "PUT /api/v1/user/update/:id" do
    let(:password) { "password" }
    let(:email) { "update@gmail.com" }
    let(:name) { "update" }
    let(:town) { Town.find("10") }
    let(:user) { FactoryBot.create(:user, town: town) }

    ####################################################################################

    describe "プロフィール編集" do
      it "プロフィールが変更されていること" do
        put api_v1_user_path(user), params: {
          user: {
            name: name,
            town_id: town,
            # TODO: S3のパス
            #avatar: "S3のパス",
          },
          auth: {
            is_authenticate: false,
            authenticate: ""
          }
        }

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data["user"]["name"]).to_not eq name
        expect(data["user"]["town_id"]).to_not eq town.id
        # TODO: 写真はどうすればいいかわからんから実装してから書く
      end

    end

    ####################################################################################

    describe "メールアドレス編集" do
      let(:user) { FactoryBot.create(
        :user,
        town: town,
        password: password,
        password_confirmation: password)
      }

      it "メールアドレスが変更されていること" do
        put api_v1_user_path(user), params: {
          user: {
            email: email,
          },
          auth: {
            is_authenticate: true,
            authenticate: password
          }
        }

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data["user"]["email"]).to_not eq user.email
      end

      it "認証が失敗すること" do
        put api_v1_user_path(user), params: {
          user: {
            email: email,
          },
          auth: {
            is_authenticate: true,
            authenticate: "miss_authenticate"
          }
        }

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data["result"]).to eq 1
      end
    end

    ####################################################################################

    describe "パスワード編集" do
      let(:user) { FactoryBot.create(
        :user,
        town: town,
        password: password,
        password_confirmation: password)
      }
      let(:new_password) { "new_password" }
      it "パスワードが変更されていること" do
        put api_v1_user_path(user), params: {
          user: {
            password: new_password,
            password_confirmation: new_password
          },
          auth: {
            is_authenticate: true,
            authenticate: password
          }
        }

        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(data["result"]).to eq 0
        expect(User.find(user.id).password_digest).to_not eq user.password_digest
      end
    end
  end

  ####################################################################################

  describe "DELETE /api/v1/user/delete/:id" do
    xit "ユーザー情報が削除されていること" do
      delete api_v1_user_path(user)

      expect(response).to have_http_status(200)
      expect{ User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    # TODO: これは関連する機能を追加したときに作成
    it "ユーザーに関連する情報が削除されていること"
  end
end