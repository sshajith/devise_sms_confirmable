module DeviseSmsConfirmable
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:action_controller) { include DeviseSmsConfirmable::Controllers::UrlHelpers }
    ActiveSupport.on_load(:action_view) { include DeviseSmsConfirmable::Controllers::UrlHelpers }
  end
end
