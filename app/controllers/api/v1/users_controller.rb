class Api::V1::UsersController < ApplicationController
  before_action :current_user, only: %i[show update destroy]

  def create
    @user = User.new(user_params)

    # デフォルトのプロフィール画像を設定
    @user.default_avatar_set
    
    if @user.save
      @result = 0
      @errors = {}
      session[:id] = @user.id
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
  end

  ####################################################################################

  def update
  end

  private

  def user_params
    params.require("user").permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :avatar,
      :town_id
    )
  end

  ####################################################################################

  def current_user
    @user = User.find(params[:id])
  end
end
