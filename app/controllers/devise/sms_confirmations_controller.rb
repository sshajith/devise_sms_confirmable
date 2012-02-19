class Devise::SmsConfirmationsController < ApplicationController
  include Devise::Controllers::InternalHelpers

  # GET /resource/sms_confirmation/new
  def new
  end

  # POST /resource/sms_confirmation
  def create
    resource = session[:resource4secret]
    sms_secret = params[:user][:sms_secret]
    if sms_secret && resource && resource.valid_secret?(sms_secret)
      begin
        warden.set_user(resource)        
        set_flash_message :notice, :signed_in
        sign_in_and_redirect(resource_name, resource)
      ensure
        session[:resource4secret] = nil
      end
    else
      set_flash_message :notice, :not_confirmed
      redirect_to new_sms_confirmation_path(resource_name)
    end
  end

end