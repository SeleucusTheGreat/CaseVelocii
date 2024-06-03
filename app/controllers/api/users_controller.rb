module Api
    class UsersController < ApplicationController
        rescue_from ActiveRecord::RecordNotFound , with: :record_not_found
        
        def show
            user = User.find(params[:id])
            respond_to do |format| 
                format.json do 
                    render json: user.to_json, status: :ok
                end
            end
        end

        private

        def record_not_found
           render json: { error: 'User not found' }, status: :not_found
        end
    end
end