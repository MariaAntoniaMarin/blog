require 'rails_helper'

RSpec.describe Follow, :type => :model do
  user_followed = User.first_or_create!(username: "Nia",
                                        password: "secret",
                                        password_confirmation: "secret")

  user_follower = User.first_or_create!(username: "Antonia",
                                        password: "secret",
                                        password_confirmation: "secret")

  subject {
    described_class.new(follower_id: user_follower.id,
                        followed_id: user_followed.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a follower" do
    subject.follower = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a followed" do
    subject.followed = nil
    expect(subject).to_not be_valid
  end

  describe Follow do
    it { should belong_to(:follower).class_name('User') }
  end

  describe Follow do
    it { should belong_to(:followed).class_name('User') }
  end
end
