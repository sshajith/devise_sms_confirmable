module Devise
  module Models
    # SmsConfirmable Module, responsible for validating sms secret while signing in.
    module SmsConfirmable
      extend ActiveSupport::Concern

      #ToDo: encrypte secret
      def sms_secret=(secret)
        @sms_secret = secret.to_s
      end

      def valid_secret?(incoming_secret)
        @sms_secret == incoming_secret.to_s
      end

    end
  end
end
