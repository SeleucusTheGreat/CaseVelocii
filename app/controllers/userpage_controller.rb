class UserpageController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  
  
  def show
  end

  def edit_user
  end


  private

  def set_user 
    @user = current_user
  end
end
