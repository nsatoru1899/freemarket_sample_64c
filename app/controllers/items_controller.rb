class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_item, only: %i[show edit update]

  def new
    @item = Item.new
    @item.images.new
    @item.build_brand
  end

  def create
    @item = Item.new(items_params)
    @item.brand.destroy if @item.brand.name == ""
    if @item.save
      render :create
    else
      @item.images.new
      render :new
    end
  end

  def show
    @user_items = Item.where(seller_id: @item.seller_id).where.not(id: @item.id).order('created_at DESC').limit(6)
    @category_items = Item.where(category_id: @item.category_id).where.not(id: @item.id).order('created_at DESC').limit(6)
  end


  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to root_path
    else
      redirect_to item_path
    end
  end
  
  def edit; end

  def update
    if @item.update(items_params)
      render :update
    else
      render :edit
    end
  end

  private

  def items_params
    params.require(:item).permit(:name, :detail, :price, :category_id, :status_id, :charge_id, :prefecture_id, :day_id, images_attributes: %i[src _destroy id], brand_attributes: %i[name]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
