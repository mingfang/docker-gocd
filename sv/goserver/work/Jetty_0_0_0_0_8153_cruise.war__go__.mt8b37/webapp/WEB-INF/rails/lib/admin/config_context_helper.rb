module Admin
  module ConfigContextHelper
    def create_config_context(registry)
      plugin_params = params.dup
      plugin_params.delete(:pipeline_group)
      com.thoughtworks.cruise.config.ConfigContext.new(registry, plugin_params)
    end
  end
end
