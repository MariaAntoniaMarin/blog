require 'rails_helper'

RSpec.describe Article, :type => :model do
  user = User.first_or_create!(username: "Antonia",
                               password: "secret",
                               password_confirmation: "secret")
  subject {
    described_class.new(title: "Test title!",
                        body: "This is a test body with 10 characters",
                        status: "public",
                        user_id: user.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a body" do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without status" do
    subject.status = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  describe Article do
    it { should belong_to(:user) }
  end

  describe Article do
    it { should have_many(:comments) }
  end
end
