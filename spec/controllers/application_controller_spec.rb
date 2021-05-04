require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  login_user = User.first_or_create!(username: "Antonia",
                                     password: "secret",
                                     password_confirmation: "secret")

  context "authentication of login user" do
    describe "=authenticate" do
      before(:each) do
        allow_any_instance_of(ApplicationController).to receive(:current_user) { login_user }
      end

      it "authenticate method" do
        subject.send(:authenticate)
        expect(response).to be_successful
      end
    end
  end
end
