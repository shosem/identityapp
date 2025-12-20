class PostsController < ApplicationController
  before_action :set_post,onle:%i[show edit update delete]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
    redirect_to @post,notice:"投稿しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post),notice:"編集しました"
    else
      render :edit,status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url,notice:"削除しました"
  end

  private

  def set_post
    @post = Post.find_by(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:text)
  end

end
