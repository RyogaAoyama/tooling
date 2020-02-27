class Api::V1::UsersController < ApplicationController
  before_action :current_user, only: %i[show update destroy]

  def create
    @user = User.new(user_params)

    # デフォルトのプロフィール画像を設定
    @user.default_avatar_set
    
    if @user.save
      @result = 0
      @errors = {}
      @user_id = @user.id
    else
      @result = 1
      # エラーメッセージをハッシュで取得
      @errors = @user.get_errors_hash
    end

    # 値を返却
    render :create, status: 200
  end

  ####################################################################################

  def show
    @result = 0
    render :show, status: 200
  end

  ####################################################################################

  def destroy
    if @user.destroy
      @result = 0
      render :destroy, status: 200
    else
      @result = 2
      render :destroy, status: 200
    end
  end

  ####################################################################################

  def update
    # 認証
    if auth_params["is_authenticate"]
      unless @user&.authenticate(auth_params[:authenticate])
        @errors = { authenticate: "パスワードが違います" }
        @result = 1
        @user = User.new
        return render :update, status: 200
      end
    end

    # 保存
    if @user.update(user_params)
      @result = 0
      return render :update, status: 200
    else
      @errors = @user.get_errors_hash
      @result = 1
      @user = User.new
      return render :update, status: 200
    end
  end

  private

  def user_params
    params.require("user").permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :town_id
    )
  end

  def auth_params
    params.require("auth").permit(
    :is_authenticate,
    :authenticate
    )
  end

  ####################################################################################

  def current_user
    @user = User.find(params[:id])
  end
end
