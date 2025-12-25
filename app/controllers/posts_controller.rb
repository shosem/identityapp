class PostsController < ApplicationController
  before_action :set_post, only:%i[show edit update destroy]

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
    redirect_to @post,success: "投稿しました"
    else
      flash.now[:danger] = "投稿できませんでした"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post),success: "編集しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit,status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url,success: "削除しました"
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:text)
  end

end
