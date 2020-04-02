class CardsController < ApplicationController
  # Payjpの利用、APIキーの設定
  require "payjp"
  Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

  def new
     card = Card.where(user_id: current_user.id)
     redirect_to root_path if card.exists?
  end

  def pay #payjpとCardのデータベース作成
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', 
      email: current_user.email, 
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to root_path
      else
        redirect_to action: "pay"
      end
    end
  end
end
