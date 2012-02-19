# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'devise_sms_confirmable/version'

Gem::Specification.new do |s|
  s.name         = "devise_sms_confirmable"
  s.version      = DeviseSmsConfirmable::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Sergey Baranov"]
  s.email        = ["baranov-sv@yandex.ru"]
  s.homepage     = "https://github.com/baranov-sv/devise_sms_confirmable"
  s.summary      = "An sms confirmation strategy for Devise"
  s.description  = "It adds support for additional confirmation through sending sms with secret to user."
  s.files        = Dir["{app,config,lib}/**/*"] + %w[LICENSE README.rdoc]
  s.require_path = "lib"
  s.rdoc_options = ["--main", "README.rdoc", "--charset=UTF-8"]

  s.required_ruby_version = '>= 1.8.7'
  s.required_rubygems_version = '>= 1.3.6'

  s.add_development_dependency('bundler', '~> 1.0.7')

  {
    'rails'  => '>= 3.0.5',
    'devise' => '>= 1.1.0'
  }.each do |lib, version|
    s.add_runtime_dependency(lib, *version)
  end
  
end
