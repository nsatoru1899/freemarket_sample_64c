class ItemsController < ApplicationController
  require "payjp"
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_item, only: %i[show edit update destroy buy pay]
  before_action :set_card, only: %i[buy pay]
  before_action :set_user_detail, only: [:buy]

  def new
    @item = Item.new
    @item.images.new
    @item.build_brand
    @category = Category.all.limit(13)
  end

  def category_children
    respond_to do |format|
      format.html
      format.json do
        @children = Category.find(params[:parent_id]).children
      end
    end
  end

  def category_grandchildren
    respond_to do |format|
      format.html
      format.json do
        @grandchildren = Category.find(params[:child_id]).children
      end
    end
  end

  def create
    @item = Item.new(items_params)
    # @item.brand.destroy if @item.brand.name == ""
    if @item.save
      render :create
    else
      @item.images.new
      @category = Category.all.limit(13)
      render :new
    end
  end

  def show
    @user_items = Item.where(seller_id: @item.seller_id).where.not(id: @item.id).order('created_at DESC').limit(6)
    @category_items = Item.where(category_id: @item.category_id).where.not(id: @item.id).order('created_at DESC').limit(6)
  end

  def destroy
    if @item.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to root_path
    else
      render edit
    end
  end

  def edit
    @item.build_brand if @item.brand.nil?
    @category = Category.all.limit(13)
  end

  def update
    if @item.update(items_params)
      render :update
    else
      render :edit
    end
  end

  def buy
    set_card_information
  end

  # Payjpを使用して支払処理
  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    charge = Payjp::Charge.create(
      amount: @item.price,
      customer: @card.customer_id,
      currency: 'jpy'
    )
    if response.status == 200
      @item.buyer = current_user
      @item.save
      render :complete
    else
      redirect_to buy_item_path
    end
  end

  private

  def items_params
    params.require(:item).permit(:name, :detail, :price, :category_id, :status_id, :charge_id, :prefecture_id, :day_id, images_attributes: %i[src _destroy id], brand_attributes: %i[name]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
    @g_category = @item.category
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end

  def set_card_information
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

    return nil if @card.blank?

    customer = Payjp::Customer.retrieve(@card.customer_id)
    # Payjpのcustomerオブジェクトのカードオブジェクトを抽出する
    @card = customer.cards.retrieve(@card.card_id)
    # 登録しているカード会社のブランドアイコンを表示する
    @card_brand = @card.brand

    case @card_brand

    when "Visa"
      @card_src = "visa.svg"
    when "JCB"
      @card_src = "jcb.svg"
    when "MasterCard"
      @card_src = "master-card.svg"
    when "American Express"
      @card_src = "american_express.svg"
    when "Diners Club"
      @card_src = "dinersclub.svg"
    when "Discover"
      @card_src = "discover.svg"
    end
  end

  def set_user_detail
    @address = Address.find(current_user.id)
    @user = User.find(current_user.id)
  end
end
