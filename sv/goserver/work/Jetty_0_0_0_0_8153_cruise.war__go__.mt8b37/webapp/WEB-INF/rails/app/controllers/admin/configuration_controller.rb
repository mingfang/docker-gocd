class Admin::ConfigurationController < AdminController
  before_filter :fetch_config , :only => [:edit]
  before_filter :tab_name, :page_title

  def show
    config_map = admin_service.populateModel(HashMap.new)
    @go_config = GoConfig.new(config_map)
    fetch_cruise_config_revision @go_config.md5
  end

  def edit
    fetch_cruise_config_revision @go_config.md5
  end

  def update
    result = HttpLocalizedOperationResult.new
    config_validity = admin_service.updateConfig(params[:go_config], result)
    unless config_validity.isValid()
      flash.now[:error] = l.string("SAVE_FAILED")
      @errors = [config_validity.errorMessage()]
      fetch_config
      if switch_to_split_pane?(config_validity)
        flash.now[:error] = l.string("FLASH_MESSAGE_ON_CONFLICT")
        @flash_help_link = l.string("HELP_LINK_CONFIGURATION_REFERENCE")
        @conflicted_config = GoConfig.new(params[:go_config])
        fetch_cruise_config_revision @go_config.md5
        render :split_pane and return
      else
        @go_config = GoConfig.new(params[:go_config].merge(:location => @go_config.location))
        fetch_cruise_config_revision @go_config.md5
        render :edit and return
      end
    end
    flash[:success] = config_validity.wasMerged() ? "#{l.string("SAVED_SUCCESSFULLY")} #{l.string("CONFIG_MERGED")}" : l.string("SAVED_SUCCESSFULLY")
    redirect_to config_view_path
  end

  private
  def fetch_config
    config_map = admin_service.configurationMapForSourceXml()
    @go_config = GoConfig.new(config_map)
  end

  def fetch_cruise_config_revision md5
    @go_config_revision = config_repository.getRevision(md5)
  end

  def switch_to_split_pane? config_validity
    !config_validity.isValid() && (config_validity.isMergeConflict() || config_validity.isPostValidationError())
  end

  def tab_name
    @tab_name = 'configuration-xml'
  end

  def page_title
    @view_title = l.string('ADMINISTRATION')
  end
end

