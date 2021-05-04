require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  user_followed = User.first_or_create!(username: "Nia",
                                        password: "secret",
                                        password_confirmation: "secret")

  user_follower = User.first_or_create!(username: "Antonia",
                                        password: "secret",
                                        password_confirmation: "secret")

  describe "POST #create" do
    before(:each) do
      allow_any_instance_of(ApplicationController).to receive(:current_user) { user_follower }
    end

    it "User follow" do
      expect {
        post :create, params: { user_id: user_followed.id }
      }.to change(Follow, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    it "user unfollow" do
      follow = user_follower.follows.new(followed: user_followed)
      follow.save
      expect {
        delete :destroy, params: { user_id: user_follower.id, id: follow.id }
      }.to change(Follow, :count).by(0)
    end
  end
end
