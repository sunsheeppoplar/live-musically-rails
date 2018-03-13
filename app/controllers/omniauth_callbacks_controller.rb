class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    service = UserIdentitiesService.from_omniauth(merged_hash)
    if service.persisted?
      sign_in_and_redirect service.user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to auth_path
    end
  end

  def stripe_connect
    service = UserIdentitiesService.from_omniauth(merged_hash, current_user)
    if service.persisted?
      sign_in_and_redirect service.user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Stripe") if is_navigational_format?
    else
      session["devise.connect_stripe_data"] = request.env["omniauth.auth"]
      redirect_to auth_path
    end
  end

  def failure
    redirect_to root_path
  end

  private
  def merged_hash
  	fb_auth_hash = request.env["omniauth.auth"]
  	fb_params_hash = request.env["omniauth.params"]

  	fb_auth_hash.merge(fb_params_hash)
  end
end