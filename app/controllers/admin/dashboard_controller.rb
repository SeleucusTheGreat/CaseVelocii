class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
    before_action :check_admin
  
    def index
      @posts = Post.all.includes(:user, :location)
    
        if params[:sort]
          direction = params[:direction] == "desc" ? "desc" : "asc"
          case params[:sort]
          when "price"
            @posts = @posts.order(price: direction)
          when "square_feet"
            @posts = @posts.order(square_feet: direction)
          when "title"
            @posts = @posts.order(title: direction)
          when "author"
            @posts = @posts.joins(:user).order("users.email #{direction}")
          when "address"
            @posts = @posts.joins(:location).order("locations.address #{direction}")
          end
        end
    end
  
    private
  
    def check_admin
      redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
    end
end
