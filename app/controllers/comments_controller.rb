class CommentsController < ApplicationController
  skip_before_action :authenticate

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
    unless current_user.follows.exists?(user1: Article.find(params[:article_id]).user)
      redirect_to current_user
    end
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user = User.find(params[:user_id])

    if @comment.save
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :status, :user_id)
  end
end
