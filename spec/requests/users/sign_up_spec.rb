RSpec.describe "Users::SignUpController", type: :request do
    
    describe "POST login" do
        
        

        let (:headers) do 
            {"ACCEPT" => "application/json"}
        end

        context "user registered" do
            it "is successful" do
                user = build(:user)
                user_params = {
                    user: {
                        email: user.email,
                        password: user.password,
                        password_confirmation: user.password,
                        full_name: user.full_name
                    }
                }
                
                post sign_up_path, params: user_params, headers: headers
                expect(response).to be_successful

                 puts "The response status is #{response.status}"
                 puts "The response body is #{response.body}"
                
            end
        end

        
    end
end