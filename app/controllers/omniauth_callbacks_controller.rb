class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(merged_hash)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
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