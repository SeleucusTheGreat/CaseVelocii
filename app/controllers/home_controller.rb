class HomeController < ApplicationController
  def index
    @posts = Post.all

    if params[:max_price].present?
      @posts = @posts.where("price <= ?", params[:max_price])
    end

    if params[:city].present?
      @posts = @posts.where(city: params[:city])
    end

    if params[:square_feet].present?
      @posts = @posts.where(num_floors: params[:square_feet])
    end

    if params[:address].present? && params[:radius].present?
      @posts = @posts.near_address(params[:address], params[:radius])
    end
  end

  private

  def post_params
    params.permit(:max_price, :price, :square_feet, :city, :address, :radius, :num_floors, photos: [])
  end
end