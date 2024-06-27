class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_params
   
  
  
    def create
        @message = Message.new(message_params.merge(sender: @sender, receiver: @receiver, post: @post))
    
        if @message.save
          redirect_to post_path(@post), notice: 'Message was successfully sent.'
        else
          render root_path
        end
    end
  
    private
  
    
  
    def set_params
      @post = Post.find(params[:post_id])
      @sender = current_user
      @receiver = User.find(@post.user.id)
    end
  
    def message_params
      params.require(:message).permit(:content)
    end
  end
  