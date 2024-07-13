class HomeController < ApplicationController
  def index
    @posts = Post.all
    filter_posts
  end

  private

  def filter_posts
    @posts = @posts.price_less_than(params[:max_price]) if params[:max_price].present?
    if (@posts.empty?) 
      flash[:alert] = "No Houses found with these prices"
      redirect_to root_path and return
    end
    @posts = @posts.in_city(params[:city]) if params[:city].present?
    if (@posts.empty?) 
      flash[:alert] = "No Houses found in this City"
      redirect_to root_path and return
    end
    @posts = @posts.with_meters(params[:square_meters]) if params[:square_meters].present?
    if (@posts.empty?) 
      flash[:alert] = "No Houses found under these Square Meters"
      redirect_to root_path and return
    end
    @posts = @posts.near_location(params[:address], params[:radius]) if params[:address].present? && params[:radius].present?
    if (@posts.empty?) 
      flash[:alert] = "No Houses found within this address and radius"
      redirect_to root_path and return
    end
  end
  

  def post_params
    params.permit(:max_price, :price, :square_meters, :city, :address, :radius, :num_floors, photos: [])
  end
end