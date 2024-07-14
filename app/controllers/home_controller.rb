class HomeController < ApplicationController
  def index
    @posts = Post.all
    filter_posts
  end

  private

  def filter_posts
    filtered = false

    @posts = @posts.price_less_than(params[:max_price]) if params[:max_price].present?
    filtered = true if params[:max_price].present?

    @posts = @posts.in_city(params[:city]) if params[:city].present?
    filtered = true if params[:city].present?

    @posts = @posts.with_meters(params[:square_meters]) if params[:square_meters].present?
    filtered = true if params[:square_meters].present?

    @posts = @posts.near_location(params[:address], params[:radius]) if params[:address].present? && params[:radius].present?
    filtered = true if params[:address].present? && params[:radius].present?

    if @posts.empty? && filtered
      flash[:alert] = "No houses found matching your criteria"
      redirect_to root_path(reset: true) and return
    elsif filtered
      flash[:alert] = "I've found #{@posts.count} houses found matching your criteria"
    end

    
  end

  def post_params
    params.permit(:max_price, :price, :square_meters, :city, :address, :radius, :num_floors, photos: [])
  end
end