require 'rails_helper'

RSpec.describe Comment, :type => :model do
  user_article = User.first_or_create!(username: "Antonia",
                                       password: "secret",
                                       password_confirmation: "secret")

  user = User.first_or_create!(username: "Venus",
                               password: "secret",
                               password_confirmation: "secret")

  article = Article.create(title: "Test title!",
                           body: "This is a test body with 10 characters",
                           status: "public",
                           user: user_article)

  subject {
    described_class.new(body: "This is a test comment body",
                        status: "public",
                        article_id: article.id,
                        user_id: user.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without status" do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a article" do
    subject.article = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  describe Comment do
    it { should belong_to(:article) }
  end

  describe Comment do
    it { should belong_to(:user) }
  end
end
