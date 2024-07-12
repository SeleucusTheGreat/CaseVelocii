# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def create
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
        user = User.find_by(email: sign_up_params[:email])
        if user 
          render json: { success: false, message: 'email already existing' }, status: :unauthorized
        else
          build_resource(sign_up_params)
          if resource.save
              sign_up(:user, resource)
              render json: { success: true, message: 'user registred ' }, status: :ok
          else
              render json: { success: false, message: "couldn't register user " }, status: :not_found
          end
        end
      end
    end
  
  end

  private 

  def sign_up_params
      params[:user][:provider] = "email"
      params[:user][:admin] = false
      params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :provider, :avatar)
  end
end
