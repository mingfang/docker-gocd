class AgentsController < ApplicationController
  include AgentBulkEditor

  AgentViewModel = com.thoughtworks.cruise.server.ui.AgentViewModel
  AgentsViewModel = com.thoughtworks.cruise.server.ui.AgentsViewModel

  ORDERS = HashWithIndifferentAccess.new({
    :ip_address => AgentViewModel.IP_ADDRESS_COMPARATOR,
    :status => AgentViewModel.STATUS_COMPARATOR,
    :hostname => AgentViewModel.HOSTNAME_COMPARATOR,
    :usable_space => AgentViewModel.USABLE_SPACE_COMPARATOR,
    :location => AgentViewModel.LOCATION_COMPARATOR,
    :resources => AgentViewModel.RESOURCES_COMPARATOR,
    :environments => AgentViewModel.ENVIRONMENTS_COMPARATOR,
    :operating_system => AgentViewModel.OS_COMPARATOR,
    :bootstrapper_version => AgentViewModel.BOOTSTRAPPER_VERSION_COMPARATOR
  })

  LISTING_MESSAGE_KEY = :agents_flash_message
  before_filter :apply_default_sort_unless_sorted, :only => :index

  layout "application"
  prepend_before_filter :set_tab_name

  def index
    @agents = agent_service.agents
    @agents.filter(params[:filter])
    @agents.sortBy(ORDERS[params[:column]], specified_order)

    @agents_disabled = @agents.disabledCount()
    @agents_pending = @agents.pendingCount()
    @agents_enabled = @agents.enabledCount()

    @flash_message = LISTING_MESSAGE_KEY
  end

  def resource_selector
    @selections = agent_service.getResourceSelections(params[:selected] || [])
    render :partial => 'shared/selectors', :locals => {:scope => {}}
  end

  def environment_selector
    @selections = agent_service.getEnvironmentSelections(params[:selected] || [])
    render :partial => 'shared/selectors', :locals => {:scope => {}}
  end

  def edit_agents
    result = bulk_edit
    session[LISTING_MESSAGE_KEY] = FlashMessageModel.new(result.message(), result.canContinue() ? 'success' : 'error')
    redirect_to :action => "index", :params => params.only(:column, :order)
  end

  private

  def populate_agent_for_details
    uuid = params[:uuid]
    @agent = agent_service.findAgentViewModel(uuid)
    if @agent.isNullAgent()
      render_error_response(l.string("AGENT_WITH_UUID_NOT_FOUND", [uuid].to_java(java.lang.String)), 404, false)
      false
    end
  end

  def apply_default_sort_unless_sorted
    params[:column] ||= "status"
    params[:order] ||= "ASC"
  end

  def specified_order default="ASC"
    com.thoughtworks.cruise.server.ui.SortOrder.orderFor(params[:order] || default)
  end

  helper_method :default_url_options
  def default_url_options(options = nil)
    super.reverse_merge(params.only(:filter, :order, :column))
  end

  def set_tab_name
    @current_tab_name = "agents"
  end
end
