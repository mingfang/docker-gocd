module ::ConfigUpdate
  module TemplatesNode
    include ::ConfigUpdate::LoadConfig
    def node(cruise_config)
      cruise_config.getTemplates()
    end
  end
end