require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }
  let(:name_err) { user.errors.messages[:name] }
  let(:email_err) { user.errors.messages[:email] }
  let(:password_err) { user.errors.messages[:password] }
  let(:confirmation_err) { user.errors.messages[:password_confirmation] }
  let(:town_id_err) { user.errors.messages[:town_id] }

  let(:min_str) { 1 }
  let(:max_str) { 50 }

  let(:str_msg) { "は#{min_str}文字以上#{max_str}文字以内で入力してください" }
  let(:empty_msg) { "を入力してください" }
  let(:form_msg) { "の形式が違います" }
  let(:forbid_msg) { "は「-_.@」以外の記号は使用できません" }
  let(:confirmation_msg) { "とパスワードの入力が一致しません" }
  let(:exsist_msg) { "はすでに存在します" }

  # 名前
  describe "name" do
    describe "文字数チェック" do
      context "50文字" do
        it "正常" do
          user.name = "a" * 50
          user.valid?
          expect(name_err).to_not include str_msg
        end
      end

      context "51文字" do
        it "異常" do
          user.name = "a" * 51
          user.valid?
          expect(name_err).to include str_msg
        end
      end
    end

    describe "空白チェック" do
      context "空文字" do
        it "異常" do
          user.name = ""
          user.valid?
          expect(name_err).to include empty_msg
        end
      end
    end
  end

  ###############################################
  # メールアドレス
  describe "email" do
    let(:min_str) { 3 }
    let(:max_str) { 256 }
    describe "文字数チェック" do
      context "256文字" do
        it "正常" do
          user.email = "a" * 256
          user.valid?
          expect(email_err).to_not include str_msg
        end
      end

      context "257文字" do
        it "異常" do
          user.email = "a" * 257
          user.valid?
          expect(email_err).to include str_msg
        end
      end
    end

    describe "空白チェック" do
      context "空文字" do
        it "異常" do
          user.email = ""
          user.valid?
          expect(email_err).to include empty_msg
        end
      end
    end

    describe "禁止文字チェック" do
      context "禁止文字あり" do
        it "異常" do
          user.email = "abc$$$@gmail.com"
          user.valid?
          expect(email_err).to include forbid_msg
        end
      end
    end

    describe "形式チェック" do
      context "行頭が記号" do
        it "異常" do
          user.email = ".abca@gmail.com"
          user.valid?
          expect(email_err).to include form_msg
        end
      end
    end

    describe "重複チェック" do
      let(:town) { FactoryBot.create(:town) }
      before do
        FactoryBot.create(:user, email: "test@gmail.com", password: "password", password_confirmation: "password", town: town)
      end
      it "異常" do
        user.email = "test@gmail.com"
        user.valid?
        expect(email_err).to include exsist_msg
      end
    end
  end

  ###############################################
  # パスワード
  describe "password" do
    let(:min_str) { 8 }
    describe "文字数チェック" do
      context "50文字" do
        it "正常" do
          user.password = "a" * 50
          user.valid?
          expect(password_err).to_not include str_msg
        end
      end

      context "51文字" do
        it "異常" do
          user.password = "a" * 51
          user.valid?
          expect(password_err).to include str_msg
        end
      end

      context "8文字" do
        it "正常" do
          user.password = "a" * 8
          user.valid?
          expect(password_err).to_not include str_msg
        end
      end

      context "7文字" do
        it "異常" do
          user.password = "a" * 7
          user.valid?
          expect(password_err).to include str_msg
        end
      end
    end

    describe "空白チェック" do
      context "空文字" do
        it "異常" do
          user.password = ""
          user.valid?
          expect(password_err).to include empty_msg
        end
      end
    end
  end

  ###############################################
  # パスワード(確認)
  describe "password_confirmation" do
    describe "一致チェック" do
      context "一致" do
        it "正常" do
          user.password = "password"
          user.password_confirmation = "password"
          user.valid?
          expect(confirmation_err).to_not include confirmation_msg
        end
      end

      context "不一致" do
        it "異常" do
          user.password = "password"
          user.password_confirmation = "miss_password"
          user.valid?
          expect(confirmation_err).to include confirmation_msg
        end
      end
    end
  end

  ###############################################
  # 住んでる都道府県
  describe "空白チェック" do
    context "空文字" do
      it "異常" do
        user.town_id = ""
        user.valid?
        expect(town_id_err).to include empty_msg
      end
    end
  end
end
