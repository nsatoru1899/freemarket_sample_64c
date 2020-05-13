class UsersController < ApplicationController
  def user_my_page
    @parents = Category.where(ancestry: nil)
   end

  def sign_out
    @parents = Category.where(ancestry: nil)
  end
end
