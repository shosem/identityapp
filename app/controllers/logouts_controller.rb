class LogoutsController < ApplicationController
  def show
    session.delete(:user_id)
    redirect_to root_path, notice:"ログアウトしました"
  end
end
