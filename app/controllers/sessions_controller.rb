class SessionsController < ApplicationController
  # このコードがなければログインするためにはログインしていなければならない、という状況になる
  skip_before_action :authenticate, only: :create

  def create
    user = User.find_or_create_from_auth_hash!(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path, notice: "ログインしました"
  end

  def destroy
    # reset_sessionでセッションに入っていた値がすべて削除されてログアウトしたことになる
    reset_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end
