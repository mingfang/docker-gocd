OauthClientsController.class_eval do
  layout 'admin'
  prepend_before_filter :set_tab_name, :set_view_title

  private

  def set_tab_name
    @tab_name = "oauth-clients"
  end

  def set_view_title
    @view_title = "Administration"
  end

end

OauthUserTokensController.class_eval do
  layout 'my-cruise'

  prepend_before_filter :set_tab_name

  def set_tab_name
    @current_tab_name = "preferences"
  end
end