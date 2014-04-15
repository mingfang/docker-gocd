Oauth2::Provider::ModelBase.instance_eval do
  def datasource
    @go_oauth_provider_datasource ||= Spring.bean("oauthRepository")
  end
end

Gadgets::ModelBase.instance_eval do
  def datasource
    @go_gadget_datasource ||= Spring.bean("gadgetRepository")
  end

  def datasource=(ds)
    @go_gadget_datasource = ds
  end
end

