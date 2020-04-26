class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
    @item.images.new
    @item.build_brand
  end

  def create
    @item = Item.new(items_params)
    @item.brand.destroy if @item.brand.name==""
    if @item.save
      redirect_to root_path
    else
      redirect_to new_item_path
    end
  end

  def show
    @user_items = Item.where(seller_id: @item.seller_id).where.not(id: @item.id).order('created_at DESC').limit(6)
    @category_items = Item.where(category_id: @item.category_id).where.not(id: @item.id).order('created_at DESC').limit(6)
  end

  def edit
  end

  def update
    if @item.update(items_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def items_params
    params.require(:item).permit(:name, :detail, :price, :category_id, :status_id, :charge_id, :prefecture_id, :day_id, images_attributes: [:src, :_destroy, :id], brand_attributes: [:name]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
