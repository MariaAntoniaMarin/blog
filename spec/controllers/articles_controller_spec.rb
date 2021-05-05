require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  user = User.first_or_create!(username: "Antonia",
                               password: "secret",
                               password_confirmation: "secret")

  let(:valid_attributes) {
    { :title => "Test title!",
      :body => "This is a test body with 10 characters",
      :status => "public" }
  }

  let(:invalid_attributes) {
    { :title => 1,
      :body => "body",
      :status => "secret" }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      article = Article.new(valid_attributes)
      article.user = user
      article.save
      article_path(article)
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      new_user_article_path(user)
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates an article" do
        expect {
          post :create, params: { article: valid_attributes, user_id: user.id }
        }.to change(Article, :count).by(1)
      end

      it "redirect to the user that created article" do
        post :create, params: { article: valid_attributes, user_id: user.id }
        expect(response).to redirect_to(Article.last.user)
      end
    end

    context "with invalid parameters" do
      it "not create an article" do
        expect {
          post :create, params: { article: invalid_attributes, user_id: user.id }
        }.to change(Article, :count).by(0)
      end

      # it "redirect to the new article view" do
      #   post :create, params: { article: invalid_attributes, user_id: user.id}
      #   expect(response).to render_template("articles/new")
      # end
    end
  end

  describe "PATCH #edit" do
    it "returns a success response" do
      article = Article.new(valid_attributes)
      article.user = user
      article.save
      edit_user_article_path(user, article)
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "redirect to the user that update article" do
        article = Article.new(valid_attributes)
        article.user = user
        article.save
        patch :update, params: { id: article.id, article: valid_attributes, user_id: user.id }
        expect(response).to redirect_to(Article.last.user)
      end
    end
  end

  describe "DELETE #destroy" do
    it "delete the article" do
      article = Article.new(valid_attributes)
      article.user = user
      article.save
      expect {
        delete :destroy, params: { id: article.id, user_id: user.id }
      }.to change(Article, :count).by(-1)
    end
  end
end
