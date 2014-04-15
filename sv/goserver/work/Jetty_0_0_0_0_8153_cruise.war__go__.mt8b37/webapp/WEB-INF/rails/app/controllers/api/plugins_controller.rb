class Api::PluginsController < Api::ApiController

  def status
    render :text => system_environment.pluginStatus()
  end
end