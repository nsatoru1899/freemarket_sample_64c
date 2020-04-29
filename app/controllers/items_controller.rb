class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  def show
    @user_items = Item.where(user_id: @item.user_id).where.not(id: @item.id).order('created_at DESC').limit(6)
    @category_items = Item.where(category_id: @item.category_id).where.not(id: @item.id).order('created_at DESC').limit(6)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
