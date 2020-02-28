class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])

    if user&.authenticate(user_params[:password])
      @user_id = user.id
      session[:id] = user.id
      @result = 0
    else
      @user_id = ""
      @error = "メールアドレスとパスワードが一致しません"
      @result = 1
    end

    render :create, status: 200
  end

  def destroy
    session[:id] = nil
    @result = 0
    render :destroy, status: 200
  end

  private

  def user_params
    params.require("user").permit(:email, :password)
  end
end