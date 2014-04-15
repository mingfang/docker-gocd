class Api::CommandsController < Api::ApiController
  layout nil

  def reload_cache
    command_repository_service.reloadCache()

    render :text => "Command Repository reloaded.\n"
  end
end