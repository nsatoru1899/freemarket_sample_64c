class CardsController < ApplicationController
  # Payjpの利用、APIキーの設定
  require "payjp"
  before_action :authenticate_user!
  before_action :set_card, except: [:create]
  before_action :set_category
  before_action :confirm_user, only: %i[show destroy]
  # カードを既に登録していたらトップページに遷移
  def new
    if @card.blank?
      @card = Card.new
    else
      redirect_to root_path
    end
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: '登録テスト',
        email: current_user.email,
        card: params['payjp-token'],
        metadata: { user_id: current_user.id }
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        set_redirect_path
      else
        redirect_to action: "new"
      end
    end
  end

  def show
    if @card.blank?
      render :show
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
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
  end

  # PayjpのサーバーとDBの情報の削除
  def destroy
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # Payjpのcustomerオブジェクトを取得。引数にPayjpのcutomer_idトークンを持たせる
    customer = Payjp::Customer.retrieve(@card.customer_id)

    if @card.destroy
      customer.delete
    else
      redirect_to action: "show"
    end
    redirect_to action: "show"
  end

  private

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end

  # 他ユーザーがアクションを動かさないようにする
  def confirm_user
    user_params = params[:id]
    if user_params != current_user.id.to_s
      redirect_to root_path
    end
  end

  def set_category
    @parents = Category.where(ancestry: nil)
  end

  def set_redirect_path
    path = Rails.application.routes.recognize_path(request.referrer)
    p_query = URI(request.referer).query
    params_p_query = Rack::Utils.parse_nested_query(p_query)
    
    if path[:controller] == "users/cards" && path[:action] == "new" 
      redirect_to card_path(current_user.id)
    else
      redirect_to buy_item_path(params_p_query["item_id"])
    end
  end

end
