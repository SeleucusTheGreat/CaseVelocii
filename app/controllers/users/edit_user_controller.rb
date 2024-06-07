class Users::EditUserController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token, only: :update
    before_action :authenticate_user!
    before_action :set_user
   

    def update
        respond_to do |format|
            format.html do
                if @user.update(sign_up_params)
                    bypass_sign_in(@user)
                    redirect_to root_path, notice: 'Your profile was successfully updated.'
                else
                    sign_in(@user)
                    redirect_to root_path, alert: "Some problem with your profile updates, please try again later"
                end
            end 
            format.json do
                if @user.update(sign_up_params)
                    render json: { success: true, message: 'user updated ' }, status: :ok
                else
                    render json: { success: false, message: 'problems during the update ' }, status: :error
                end
            end
        end
    end

    private 

    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :provider, :avatar)
    end

    def set_user
        @user = current_user
    end



end