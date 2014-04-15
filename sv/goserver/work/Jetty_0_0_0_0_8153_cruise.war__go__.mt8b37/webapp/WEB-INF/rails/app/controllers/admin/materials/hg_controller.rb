module Admin::Materials
  class HgController < ::Admin::MaterialsController
    private

    def load_new_material(cruise_config)
      assert_load :material, HgMaterialConfig.new("", nil)
    end
  end
end