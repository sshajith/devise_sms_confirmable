require 'devise'

module DeviseSmsConfirmable
  autoload :Provider, 'devise_sms_confirmable/provider'
end

require 'devise_sms_confirmable/routes'
require 'devise_sms_confirmable/controllers/internal_helpers.rb'
require 'devise_sms_confirmable/controllers/url_helpers'
require 'devise_sms_confirmable/rails'

module Devise
  # sms_confirmation_field: model field which store phone for sms confirmation 
  mattr_accessor :sms_confirmation_field
  @@sms_confirmation_field = :phone_for_sms
  # sms_confirmation_method: method of ApplicationController which return true if sms confirmation requred.
  mattr_accessor :sms_confirmation_method
  @@sms_confirmation_method = :sms_confirmation?
  # sms_secret_method: method of ApplicationController which return secret for sending
  mattr_accessor :sms_secret_method
  @@sms_secret_method = :sms_secret
  # sms_provider: special object which uses for sending SMS. It must have at least one method send_sms(phone, message) which return true or false
  mattr_accessor :sms_provider
  @@sms_provider = DeviseSmsConfirmable::Provider
  # default_provider_silent: if true default provider does't send sms
  mattr_accessor :default_provider_silent
  @@default_provider_silent = false
  # default_provider_login
  mattr_accessor :default_provider_login
  @@default_provider_login = "tstest1001"
  # default_provider_password
  mattr_accessor :default_provider_password
  @@default_provider_password = "tstest1001"
end

Devise.add_module :sms_confirmable, :controller => :sms_confirmations, :model => 'devise_sms_confirmable/model' ,:route => :sms_confirmation
