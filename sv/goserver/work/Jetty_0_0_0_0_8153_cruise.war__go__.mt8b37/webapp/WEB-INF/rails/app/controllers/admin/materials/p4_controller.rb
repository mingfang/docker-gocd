module Admin::Materials
  class P4Controller < ::Admin::MaterialsController
    private

    def load_new_material(cruise_config)
      assert_load :material, P4MaterialConfig.new("", "")
    end
  end
end