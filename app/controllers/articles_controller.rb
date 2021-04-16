class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @articles = Articles.find(params[:id])
  end
end
