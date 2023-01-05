class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # protect_from_forgery   #記事を参考にした

  private

  def after_sign_in_path_for(resource)
    # root_path
    user_path(resource) #userの詳細ページに飛びたい
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
