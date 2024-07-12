# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def create
    respond_to do |format|
      format.html do
        user = User.find_by(email: sign_up_params[:email])         
        if user && user.valid_password?(sign_up_params[:password])
          sign_in(user)
          redirect_to root_path, notice: 'Logged in successfully.'
        else
          flash[:show_sign_up_modal] = true
          redirect_to root_path, alert: 'Invalid email or password.'
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

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
