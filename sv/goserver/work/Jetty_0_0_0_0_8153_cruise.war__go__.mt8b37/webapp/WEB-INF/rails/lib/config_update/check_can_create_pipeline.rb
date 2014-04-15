module ConfigUpdate
  module CheckCanCreatePipeline

    include ::ConfigUpdate::LoadConfig

    def has_permission(cruise_config)
      group_name = (params[:pipeline_group] && params[:pipeline_group][:group])
      group_name = (group_name.nil? || group_name.empty?) ? com.thoughtworks.cruise.config.PipelineConfigs::DEFAULT_GROUP : group_name
      cruise_config.hasPipelineGroup(group_name) ? @security_service.isUserAdminOfGroup(@user.getUsername(), group_name) : @security_service.isUserAdmin(@user)
    end

    def checkPermission(cruise_config, result)
      return if has_permission(cruise_config)

      message = com.thoughtworks.cruise.i18n.LocalizedMessage.string("UNAUTHORIZED_TO_CREATE_PIPELINE")
      result.unauthorized(message, nil)
    end
  end
end