require 'rails_helper'

user = User.first_or_create!(username: "Antonia",
                             password: "secret",
                             password_confirmation: "secret")

describe AuthenticationHelper do
  describe "#login" do
    it "returns a success response" do
      helper.log_in(user)
      expect(response).to be_successful
    end
  end

  describe "#current_user" do
    it "return a current user" do
      helper.log_in(user)
      expect(current_user).to eq(user)
    end
  end

  describe "#logged_in?" do
    it "returns true for logged user" do
      helper.log_in(user)
      helper.logged_in?
      expect(response).to be_truthy
    end
  end

  describe "#logout" do
    it "returns a success response and nill current user" do
      helper.log_in(user)
      helper.log_out
      expect(response).to be_successful
      expect(current_user).to eq(nil)
    end
  end

  describe "#current_user?" do
    it "returns true for logged user" do
      helper.log_in(user)
      helper.current_user?(user)
      expect(response).to be_truthy
    end
  end
end
