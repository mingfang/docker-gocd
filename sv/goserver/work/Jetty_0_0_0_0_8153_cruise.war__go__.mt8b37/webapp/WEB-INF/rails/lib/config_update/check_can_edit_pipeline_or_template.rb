module ConfigUpdate
  module CheckCanEditPipelineOrTemplate

    include ::ConfigUpdate::LoadConfig

    def has_permission(cruise_config)
      if looking_at_template?
        @security_service.isAuthorizedToEditTemplate(template_name, com.thoughtworks.cruise.server.util.UserHelper.getUserName())
      else
        @security_service.isUserAdminOfGroup(@user, load_pipeline_group(cruise_config))
      end
    end

    def checkPermission(cruise_config, result)
      return if has_permission(cruise_config)

      message = com.thoughtworks.cruise.i18n.LocalizedMessage.string("UNAUTHORIZED_TO_EDIT")
      message = com.thoughtworks.cruise.i18n.LocalizedMessage.string("UNAUTHORIZED_TO_EDIT_GROUP", [pipeline_group_name]) if !pipeline_group_name.nil?
      message = com.thoughtworks.cruise.i18n.LocalizedMessage.string("UNAUTHORIZED_TO_EDIT_PIPELINE", [pipeline_name]) if !pipeline_name.isBlank()

      result.unauthorized(message, nil)
    end
  end
end