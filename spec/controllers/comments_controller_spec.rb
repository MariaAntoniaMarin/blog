require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  user_article = User.first_or_create!(username: "Nia",
                                       password: "secret",
                                       password_confirmation: "secret")

  user = User.first_or_create!(username: "Antonia",
                               password: "secret",
                               password_confirmation: "secret")

  article = Article.create(title: "Test title!",
                           body: "This is a test body with 10 characters",
                           status: "public",
                           user: user_article)

  let(:valid_attributes) {
    { :body => "Amazing Article!",
      :status => "public",
      :user_id => user.id }
  }

  let(:invalid_attributes) {
    { :body => 1,
      :status => "secret" }
  }

  describe "GET #index" do
    it "returns a success response" do
      article_comments_path(article)
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      new_user_article_comment_path(user, article)
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a comment" do
        expect {
          post :create, params: { comment: valid_attributes, article_id: article.id, user_id: user.id }
        }.to change(Comment, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "not create a user" do
        expect {
          post :create, params: { comment: invalid_attributes, article_id: article.id, user_id: user.id }
        }.to change(Comment, :count).by(0)
      end
    end
  end

  describe "DELETE #destroy" do
    it "delete the article" do
      comment = article.comments.create(valid_attributes)
      comment.user = user
      comment.save
      expect {
        delete :destroy, params: { id: comment.id, article_id: article.id, user_id: user.id }
      }.to change(Comment, :count).by(-1)
    end
  end
end
