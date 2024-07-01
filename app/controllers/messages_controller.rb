class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_and_chat

  def create
    @message = @chat.messages.new(message_params)
    @message.sender = current_user
    @message.post = @post

    if @message.save
      redirect_to post_chat_path(@post, @chat), notice: 'Message sent successfully.'
    else
      redirect_to @post, alert: 'Failed to send message.'
    end
  end

  private

  def set_post_and_chat
    @post = Post.find(params[:post_id])
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end