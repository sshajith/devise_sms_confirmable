module DeviseSmsConfirmable
  module Generators
    class DeviseSmsConfirmableGenerator < Rails::Generators::NamedBase
      namespace "devise_sms_confirmable"

      desc "Add :sms_confirmable directive in the given model."

      def inject_devise_sms_confirmable_content
        path = File.join("app", "models", "#{file_path}.rb")
        inject_into_file(path, "sms_confirmable, :", :after => "devise :") if File.exists?(path)
      end

      #hook_for :orm
    end
  end
end