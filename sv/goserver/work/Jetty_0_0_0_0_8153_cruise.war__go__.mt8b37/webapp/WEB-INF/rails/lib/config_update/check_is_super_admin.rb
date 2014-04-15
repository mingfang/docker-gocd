module ConfigUpdate
  module CheckIsSuperAdmin

    include ::ConfigUpdate::LoadConfig

    def checkPermission(cruise_config, result)
      return if @security_service.isUserAdmin(@user)
      
      message = com.thoughtworks.cruise.i18n.LocalizedMessage.string("UNAUTHORIZED_TO_ADMINISTER")
      result.unauthorized(message, nil)
    end
  end
end