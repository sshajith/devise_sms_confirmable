module DeviseSmsConfirmable
  class DeviseSmsConfirmableError < RuntimeError; end
  class ConfirmationMethodNotFound < DeviseSmsConfirmableError; end
  class SecretMethodNotFound < DeviseSmsConfirmableError; end
  class ConfirmationFieldNotFound < DeviseSmsConfirmableError; end
  class ValidSendSmsMethodNotFound  < DeviseSmsConfirmableError; end

  module Controllers
    # This module will be included to Devise::Controllers::InternalHelpers if sms confirmation module uses. See ../roures.rb
    module InternalHelpers
      extend ActiveSupport::Concern

      # Helper for use in before_filters where sms confirmation is required
      # Automatically appended to Devise::SessionsController
      def require_sms_confirmation
        confirmation_method = Devise::sms_confirmation_method
        raise ConfirmationMethodNotFound unless InternalHelpers::valid_method?(self, confirmation_method)
        if self.__send__(confirmation_method)
          resource = warden.authenticate(:scope => resource_name)
          if resource
            begin
              secret_method = Devise::sms_secret_method
              raise SecretMethodNotFound unless InternalHelpers::valid_method?(self, secret_method)
              secret = self.__send__(secret_method)
              resource.sms_secret = secret                            
              confirmation_field = Devise::sms_confirmation_field
              raise ConfirmationFieldNotFound unless InternalHelpers::valid_method?(resource, confirmation_field)
              phone = resource.__send__(confirmation_field)
              if phone.blank?
                set_flash_message :alert, :phone_not_found
              else
                provider = Devise::sms_provider
                raise ValidSendSmsMethodNotFound unless InternalHelpers::valid_method?(provider, :send_sms)
                if provider.__send__(:send_sms, phone, secret)
                  session[:resource4secret] = resource
                  set_flash_message :notice, :send_sms_success
                else
                  set_flash_message :alert, :send_sms_fail
                end
              end 
              redirect_to new_sms_confirmation_path(resource_name)
            ensure
              warden.logout(resource_name)  
            end
          end
        end
      rescue DeviseSmsConfirmableError, ArgumentError
        raise "DeviseSmsConfirmable module error: #{$!.message} "
      end
      
      # Append require_sms_confirmation to before filters of Devise::SessionsController
      included do
        class_eval { append_before_filter :require_sms_confirmation, :only => [ :create ] if self == Devise::SessionsController}
      end

      # Check if method is valid for caller
      def self.valid_method?(caller, method)
        method.kind_of?(Symbol) && caller.respond_to?(method) 
      end 
      
    end
  end
end
