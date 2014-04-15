class AgentAutocompleteController < ApplicationController

  def resource
    resources = cruise_config_service.getResourceList()
    render :json => starts_with_search_string(resources)
  end

  def status
    status_vals = AgentStatus.values()
    status_vals = status_vals.map {|status| status.name().downcase}
    render :json => starts_with_search_string(status_vals)
  end

  def environment
    env_names = environment_config_service.environmentNames()
    env_names = env_names.map {|env| env.toString()}
    render :json => starts_with_search_string(env_names)
  end

  def name
    names = agent_service.getUniqueAgentNames()
    render :json => starts_with_search_string(names)
  end

  def ip
    ip_addrs = agent_service.getUniqueIPAddresses()
    render :json => starts_with_search_string(ip_addrs)
    end

  def os
    os_list = agent_service.getUniqueAgentOperatingSystems()
    render :json => starts_with_search_string(os_list)
  end

  private

  def starts_with_search_string(list)
    query = params[:q].downcase
    list.select { |item| item.downcase.start_with?(query) }.inject("") {|init, item| init + "\n" + item }.strip
  end

end
