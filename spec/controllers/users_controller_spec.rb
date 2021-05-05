require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    { :username => "Ant",
      :password => "secret",
      :password_confirmation => "secret" }
  }

  let(:invalid_attributes) {
    { username: 1,
      password: 2,
      password_confirmation: 3 }
  }

  describe "GET #index" do
    it "returns a success response" do
      users_path
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = User.first_or_create!(valid_attributes)
      user_path(user)
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      new_user_path
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a user" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirect to the user created" do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid parameters" do
      it "not create a user" do
        expect {
          post :create, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end
    end
  end

  describe "PATCH #edit" do
    it "returns a success response" do
      user = User.first_or_create!(valid_attributes)
      edit_user_path(user.id)
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "redirect to the user that update article" do
        user = User.first_or_create!(valid_attributes)
        patch :update, params: { id: user.id, user: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
