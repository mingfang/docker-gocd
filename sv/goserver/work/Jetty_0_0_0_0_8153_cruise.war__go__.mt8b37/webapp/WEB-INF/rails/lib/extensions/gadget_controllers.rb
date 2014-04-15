GadgetsOauthClientsController.class_eval do
  layout 'admin'

  prepend_before_filter :set_tab_name, :set_view_title

  def set_tab_name
    @tab_name = "gadget-providers"
  end

  def set_view_title
    @view_title = "Administration"
  end
end

