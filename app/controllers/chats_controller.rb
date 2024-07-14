class ChatsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @chats = current_user.chats.order(last_message_at: :desc)
    end
  
    def show
      @post = Post.find(params[:post_id])
      @chat = Chat.find(params[:id])
      authorize_chat
      @messages = @chat.messages.order(created_at: :asc)
      @new_message = Message.new
      @other_user = @chat.other_user(current_user)
    end
  
    private
  
    def authorize_chat
      unless @chat.buyer == current_user || @chat.owner == current_user
        redirect_to root_path, alert: 'You do not have permission to view this chat.'
      end
    end
  end