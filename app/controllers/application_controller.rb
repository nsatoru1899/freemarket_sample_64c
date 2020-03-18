class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception


  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :familyname, :firstname, :familyname_kana, :firstname_kana, :phonenumber, :birth_date, :detail, address_attributes:[:postal_code, :prefecture_code, :city, :block, :building]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :familyname, :firstname, :familyname_kana, :firstname_kana, :phonenumber, :birth_date, :detail, address_attributes:[:postal_code, :prefecture_code, :city, :block, :building]])
  end
end