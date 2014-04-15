class Admin::Plugins::PluginsController < AdminController

  before_filter :set_tab_name

  def index
    @plugin_descriptors = default_plugin_manager.plugins().collect {|descriptor| GoPluginDescriptorModel::convertToDescriptorWithAllValues descriptor}.sort { |plugin1, plugin2| plugin1.about().name().downcase <=> plugin2.about().name().downcase }
    @external_plugin_location = system_environment.getExternalPluginAbsolutePath()
  end

  private
  def set_tab_name
    @tab_name = 'plugins-listing'
  end
end