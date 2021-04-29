class ArticlesController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @user = User.find(params[:user_id])

    unless current_user?(@user)
      redirect_to root_path
    end
  end

  def create
    @user = User.find(params[:user_id])
    @article = @user.articles.new(article_params)

    if @article.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    @user = User.find(params[:user_id])

    unless current_user?(@user)
      redirect_to root_path
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article.user
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to @article.user
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
