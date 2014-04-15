class AgentAPIModel
  attr_reader :uuid, :agent_name, :ip_address, :sandbox, :status, :build_locator, :os, :free_space, :resources, :environments

  def initialize(agent_view_model)
    @uuid = agent_view_model.getUuid()
    @agent_name = agent_view_model.getHostname()
    @ip_address = agent_view_model.getIpAddress()
    @sandbox = agent_view_model.getLocation()
    @status = agent_view_model.getStatusForDisplay()
    @build_locator = agent_view_model.buildLocator()
    @os = agent_view_model.getOperatingSystem()
    @free_space = agent_view_model.freeDiskSpace().toString()
    @resources  = agent_view_model.getResources()
    @environments = agent_view_model.getEnvironments()
  end
end