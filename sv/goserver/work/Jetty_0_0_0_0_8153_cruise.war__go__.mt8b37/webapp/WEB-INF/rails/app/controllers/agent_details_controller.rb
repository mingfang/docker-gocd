class AgentDetailsController < ApplicationController
  JobHistoryColumns = com.thoughtworks.cruise.server.service.JobInstanceService::JobHistoryColumns

  PAGE_SIZE = 50

  before_filter :populate_agent_for_details

  layout "application", :except => [:show, :job_run_history]
    prepend_before_filter :set_tab_name

  def show
    render :layout => "agent_detail"
  end

  def job_run_history
    params[:page] ||= 1
    @job_instances = job_instance_service.completedJobsOnAgent(params[:uuid], JobHistoryColumns.valueOf(params[:column] || "completed"), specified_order("DESC"), params[:page].to_i, PAGE_SIZE)
    render :layout => "agent_detail"
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

  def specified_order default="ASC"
    com.thoughtworks.cruise.server.ui.SortOrder.orderFor(params[:order] || default)
  end

   def set_tab_name
      @current_tab_name = "agents"
    end
end
