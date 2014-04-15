module ::GoSslHelper
  def self.included base
    base.alias_method_chain :mandatory_ssl, :config_enforcement
  end

  def mandatory_ssl_with_config_enforcement
    if Thread.current[:ssl_base_url].nil?
      @message = l.string("SSL_ENFORCED_BUT_BASE_NOT_FOUND")
      @status = 404
      render 'shared/ssl_not_configured_error', :status => @status, :layout => true
      return false
    end
    mandatory_ssl_without_config_enforcement
  end
end

[Gadgets::SslHelper, Oauth2::Provider::SslHelper].each do |helper|
  helper.class_eval { include ::GoSslHelper }
end

