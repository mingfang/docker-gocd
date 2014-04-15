module Admin::Materials
  class PackageController < ::Admin::MaterialsController
    private

    def load_other_form_objects(cruise_config)
      @original_cruise_config = cruise_config_service.getConfigForEditing()
      return unless @material && @material.getPackageDefinition() && @material.getPackageDefinition().getRepository()
      repo = @material.getPackageDefinition().getRepository()
      plugin_id = repo.getPluginConfiguration().getId()
      package_configurations = PackageMetadataStore.getInstance().getMetadata(plugin_id)
      @package_configuration = PackageViewModel.new(package_configurations, @material.getPackageDefinition())
    end

    def get_node_for_create
      @cruise_config.pipelineConfigByName(CaseInsensitiveString.new(params[:pipeline_name]))
    end

    def get_create_command
      if (params[:material][:create_or_associate_pkg_def] == "create")
        command = PackageMaterialAddWithNewPackageDefinitionCommand.new(package_definition_service, security_service, params[:pipeline_name], @material, current_user, params[:material])
      else
        command = PackageMaterialAddWithExistingPackageDefinitionCommand.new(package_definition_service, security_service, params[:pipeline_name], @material, current_user, params[:material])
      end
      command
    end

    def get_update_command
      cruise_config = cruise_config_service.getConfigForEditing()
      pipeline_config = cruise_config.pipelineConfigByName(CaseInsensitiveString.new(params[:pipeline_name]))
      material = pipeline_config.materialConfigs().getByFingerPrint(params[:finger_print])
      if (params[:material][:create_or_associate_pkg_def] == "create")
        command = PackageMaterialUpdateWithNewPackageDefinitionCommand.new(package_definition_service, security_service, params[:pipeline_name], material, current_user, params[:material])
      else
        command = PackageMaterialUpdateWithExistingPackageDefinitionCommand.new(package_definition_service, security_service, params[:pipeline_name], material, current_user, params[:material])
      end
      command
    end

    def load_new_material(cruise_config)
      assert_load :material, PackageMaterialConfig.new
    end
  end
end