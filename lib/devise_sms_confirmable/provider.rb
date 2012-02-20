require 'open-uri' 
require 'base64'


module DeviseSmsConfirmable
  # Module responsible to sending SMS
  module Provider
    GET_URL = "http://gate.prostor-sms.ru/send/?phone=+%s&text=%s"

    # Send sms via SMS Gate 
    def self.send_sms(dest_address, sms_data)
      return true if Devise::default_provider_silent
      #ToDo: handle too long sms_data
      auth = "#{Devise::default_provider_login}:#{Devise::default_provider_password}"
      url = GET_URL % ["#{dest_address}".sub('+',''), sms_data]
      begin
        result = open(
          URI.escape(url),
          "Authorization" => "Basic " << Base64.encode64(auth)
        ).read
        puts "Default provider send result: #{result}"
        result.match("accept") ? true : false
      rescue OpenURI::HTTPError, URI::Error
        puts "Default provider error : #{$!.message}"
        puts $!.backtrace.join("\n")
        false
      end
    end
  end
end