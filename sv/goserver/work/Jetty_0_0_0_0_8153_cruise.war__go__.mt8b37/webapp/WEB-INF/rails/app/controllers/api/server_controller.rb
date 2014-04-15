class Api::ServerController < Api::ApiController
  def info
    @base_url = system_environment.getBaseUrlForShine()
    @base_ssl_url = system_environment.getBaseSslUrlForShine()
    @artifacts_dir = cruise_config_service.artifactsDir().getAbsolutePath()
    @shine_db_path = system_environment.shineDb().getAbsolutePath()
    @config_dir = system_environment.configDir().getAbsolutePath()
  end

  def capture_support_info
    file = server_status_service.captureServerInfo(current_user, result = HttpLocalizedOperationResult.new)
    if !result.isSuccessful()
      render_localized_operation_result result
    else
      send_file file.getAbsolutePath(), :disposition => "inline", :stream => false, :type => "text"
    end
  end
end