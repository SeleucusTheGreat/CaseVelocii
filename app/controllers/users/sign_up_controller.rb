class Users::SignUpController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token, only: :signup
  
   

    def signup
      respond_to do |format|
        format.html do
          user = User.find_by(email: sign_up_params[:email])
          if user 
            redirect_to root_path, notice: 'user with this email already exists'
          else
            build_resource(sign_up_params)
            if resource.save
                sign_up(:user, resource)
                redirect_to root_path, notice: 'Signed up successfully.'
              else
                clean_up_passwords(resource)
                set_minimum_password_length
            end
          end
        end
  
        format.json do
          user = User.find_by(email: params[:email])
          
          if user && user.valid_password?(params[:password])
            sign_in(user)
            render json: { success: true, message: 'Logged in successfully.' }, status: :ok
          else
            render json: { success: false, message: 'Invalid email or password.' }, status: :unauthorized
          end
        end
      end
    end

    private 

    def sign_up_params
        params[:user][:provider] = "email"
        params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :provider)
    end


end

 

 