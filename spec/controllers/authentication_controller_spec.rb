require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  user = User.first_or_create!(username: "Antonia",
                               password: "secret",
                               password_confirmation: "secret")

  describe "GET #new" do
    it "returns a success response" do
      login_path
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid credentials" do
      it "Login" do
        post :create, params: { username: "Antonia", password: "secret" }
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid credentials" do
      it "Login with wrong password" do
        post :create, params: { username: "Antonia", password: "topsecret" }
        expect(flash[:alert]).to match("Invalid username/password combination")
      end

      it "Login with wrong username" do
        post :create, params: { username: "Atonia", password: "secret" }
        expect(flash[:alert]).to match("Could not find User")
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user) { user }
    end

    it "logout" do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
