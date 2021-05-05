require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    described_class.new(username: "Venus",
                        password: "secret",
                        password_confirmation: "secret")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  describe User do
    it { should have_many(:articles) }
  end

  describe User do
    it { should have_many(:comments) }
  end

  describe User do
    it { should have_many(:follows) }
  end
end
