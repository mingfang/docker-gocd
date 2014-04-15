module Admin::Materials
  class GitController < ::Admin::MaterialsController
    private

    def load_new_material(cruise_config)
      assert_load :material, GitMaterialConfig.new("")
    end
  end
end