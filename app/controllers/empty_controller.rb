class EmptyController < ActionController::Base
  def show
   @users = User.all
  end
end
