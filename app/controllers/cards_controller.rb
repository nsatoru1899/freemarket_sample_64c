class CardsController < ApplicationController
  # Payjpの利用、APIキーの設定
  require "payjp"
  Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

  # カードを既に登録していたらトップページに遷移
  def new
    card = Card.where(user_id: current_user.id)
    if card.exists?
      redirect_to root_path
    else
      @card = Card.new
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
        redirect_to root_path
      else
        redirect_to action: "new"
      end      
    end
  end

  def show
    card = Card.where(user_id: current_user.id).first
    @card = card
    if card.blank?
      render :show
    else
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    # Payjpのcustomerオブジェクトのカードオブジェクトを抽出する
    @card = customer.cards.retrieve(card.card_id)
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

  def destroy #PayjpのサーバーとDBの情報の削除
    #削除したいカードの情報を持ってくる。current_userのカード情報
    card = Card.where(user_id: current_user.id)
    if card.blank?
      render :new
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      # Payjoのcustomerオブジェクトを取得。引数にPayjpのcutomer_idトークンを持たせる
      customer = Payjp::Customer.retrieve(card.customer_id)
      card =customer.retrieve(card.card_id)
      customer.delete
      card.delete
      redirect_to_root_path
    end
  end
end
