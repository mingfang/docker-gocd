module Admin::Materials
  class TfsController < ::Admin::MaterialsController
    private

    def load_new_material(cruise_config)
      assert_load :material, TfsMaterialConfig.new(CruiseCipher.new, UrlArgument.new(""), "", "", "", "")
    end
  end
end