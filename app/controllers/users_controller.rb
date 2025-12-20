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
      render :new, status: :unprocessable_entity 
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice:"ユーザーの更新に成功しました"
    else
      render :edit,status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notie:"ユーザーの削除に成功しました"
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :highest_rank, :password, :password_confirmation)
  end

  def set_index_title
    @index_title = "ユーザー一覧"
  end

  def set_show_title
    @show_title = "ユーザー詳細"
  end

end
