module Admin::Materials
  class SvnController < ::Admin::MaterialsController
    private

    def load_new_material(cruise_config)
      assert_load :material, SvnMaterialConfig.new("", "", "", false)
    end
  end
end