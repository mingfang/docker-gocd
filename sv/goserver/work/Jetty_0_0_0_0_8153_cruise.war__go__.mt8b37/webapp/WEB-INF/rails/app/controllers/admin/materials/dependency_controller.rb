module Admin::Materials
  class DependencyController < ::Admin::MaterialsController
    include ::Admin::DependencyMaterialAutoSuggestions

    private
    def load_other_form_objects(cruise_config)
      assert_load :pipeline_stages_json, pipeline_stages_json(cruise_config, current_user, security_service, params)
    end

    def load_new_material(cruise_config)
      assert_load :material, DependencyMaterialConfig.new(CaseInsensitiveString.new(""), CaseInsensitiveString.new(""))
    end
  end
end
