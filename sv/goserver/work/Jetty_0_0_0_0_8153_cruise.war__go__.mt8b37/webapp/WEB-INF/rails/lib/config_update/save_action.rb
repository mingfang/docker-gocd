module ConfigUpdate
  class SaveAction
    include com.thoughtworks.cruise.config.update.UpdateConfigFromUI
    include ::ConfigUpdate::RefsAsUpdatedRefs
    attr_reader :params

    def initialize params, user, security_service
      @params = params
      @user = user
      @security_service = security_service
    end
  end
end