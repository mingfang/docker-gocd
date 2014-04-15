# applications can change these to suit your needs
Gadgets.init do |config|
  config.application_name = 'Go'
  config.application_base_url = proc { Thread.current[:base_url].gsub(/\/+$/, '') + "/go" }
  config.ssl_base_url = proc { Thread.current[:ssl_base_url].gsub(/\/+$/, '') + "/go" }
  if RAILS_ENV == 'test'
    config.truststore_path = File.join(Rails.root, 'tmp', "gadget_truststore.jks")
  else
    config.truststore_path = File.join(com.thoughtworks.cruise.util.SystemEnvironment.new.configDir().getAbsolutePath(), "gadget_truststore.jks")
  end
end
