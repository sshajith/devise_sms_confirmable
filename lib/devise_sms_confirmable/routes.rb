module ActionDispatch::Routing
  class Mapper

  protected
    def devise_sms_confirmation(mapping, controllers)
      resource :sms_confirmation, :only => [:new, :create], :path => mapping.path_names[:sms_confirmation], :controller => controllers[:sms_confirmations]
      # if these routes created then module sms_confirmable is using so add special helpres for Devise::Controllers::InternalHelpers
      Devise::Controllers::InternalHelpers.send(:include, DeviseSmsConfirmable::Controllers::InternalHelpers)
    end

  end
end
