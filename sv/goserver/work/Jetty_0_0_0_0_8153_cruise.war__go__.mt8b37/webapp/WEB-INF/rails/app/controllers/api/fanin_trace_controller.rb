class Api::FaninTraceController < Api::ApiController
  def fanin_trace
    cruise_config = cruise_config_service.getCurrentConfig()
    pipeline_name = params[:name]
    reporting_fanin_graph = ReportingFanInGraph.new(cruise_config, pipeline_name, pipeline_sql_map_dao)
    @str = reporting_fanin_graph.computeRevisions(pipeline_service.getPipelineTimeline())
    render :text => "<pre>" + @str + "</pre>"
  end

  def fanin
    cruise_config = cruise_config_service.getCurrentConfig()
    pipeline_name = params[:name]
    output = "<pre>" + "\n"
    revisions = pipeline_service.getRevisionsBasedOnDependenciesForReporting(cruise_config, CaseInsensitiveString.new(pipeline_name))
    render :text => "No Fan-In" and return unless revisions
    revisions.each do |rev|
      newline = "\n   "
      output = output + "Material: " + rev.getMaterial().to_s + "\n"
      output = output + "***" + newline
      rev.getModifications().each do |mod|
        output = output + "Revision: " + mod.getRevision() + newline
        output = output + "Modified-Time: " + mod.getModifiedTime().to_s + newline
        output = output + "Fingerprint: " + mod.getMaterialInstance().getFingerprint() + newline
        output = output + "Flyweight-Name: " + mod.getMaterialInstance().getFlyweightName() + "\n"
        output = output + "***\n"
      end
      output = output + "---\n\n"
    end
    output = output + "</pre>"
    render :text => output
  end
end