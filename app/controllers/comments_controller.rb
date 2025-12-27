class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, success: "コメントを投稿しました"
    else
      redirect_to @post, danger: "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @comment = @post.comments.find_by(id: params[:id])
    @comment.soft_destroy # deletedカラムをtrueにする
    redirect_to @post, success: "コメントを削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
