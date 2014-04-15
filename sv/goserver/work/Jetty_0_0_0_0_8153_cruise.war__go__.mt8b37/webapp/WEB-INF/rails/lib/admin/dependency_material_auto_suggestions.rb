module Admin
  module DependencyMaterialAutoSuggestions
    include JavaImports

    def pipeline_stages_json(cruise_config, current_user, security_service, params)
      pipelines = cruise_config.getAllPipelineConfigs()
      pipeline_stages_array = Array.new
      pipelines.each do |pipeline|
        unless pipeline.name() == CaseInsensitiveString.new(params[:pipeline_name])
          pipeline.each do |stage|
            pipeline_stages_array.push({:pipeline=> pipeline.name().to_s, :stage => stage.name().to_s}) if security_service.hasViewOrOperatePermissionForPipeline(current_user, pipeline.name().to_s)
          end
        end
      end
      pipeline_stages_array.sort_by {|item| item[:pipeline].downcase}.to_json
    end
  end
end