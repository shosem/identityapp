class UsersController < ApplicationController
  before_action :set_user,only:%i[show edit update destroy]
  
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user), notice:"ユーザー登録に成功しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :highest_rank)
  end

  def set_index_title
    @index_title = "ユーザー一覧"
  end

  def set_show_title
    @show_title = "ユーザー詳細"
  end

end
