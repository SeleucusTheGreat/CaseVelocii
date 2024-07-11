class NotificationsController < ApplicationController
    before_action :authenticate_user!, :check_params
  
    def mark_and_redirect
        @notification = current_user.received_notifications.find(params[:id])
        mark_as_read
        redirect_to post_chat_path(@notification.message.post, @notification.message.chat)
    end

    private 
    def mark_as_read
        if (@notification.read==false)
            @notification.update(read: true)
        end
    end

    def check_params
        params.permit(:id)    
    end
end
  