require 'rails_helper'

RSpec.describe "Users::LogInController", type: :request do
    describe "GET login" do

        let (:headers) do 
            {"ACCEPT" => "application/json"}
        end

        context "user exists" do
            it "is successful" do
                user = create(:user)
                get sign_in_path(email: user.email, password: user.password), headers: headers
                expect(response).to be_successful

               


            end
        end

        
    end
end