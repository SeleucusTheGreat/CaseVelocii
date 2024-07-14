class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    if params[:chat_id] == 'new'
      @chat =  Chat.find_or_create_by(post: @post, buyer: current_user, owner: @post.user)
    else
      @chat =  Chat.find(params[:chat_id])
    end
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

  def set_post
    @post = Post.find(params[:post_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end