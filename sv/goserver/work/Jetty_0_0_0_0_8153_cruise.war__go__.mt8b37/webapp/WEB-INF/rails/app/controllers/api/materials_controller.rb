class Api::MaterialsController < Api::ApiController

  def notify
    result = HttpLocalizedOperationResult.new
    material_update_service.notifyMaterialsForUpdate(current_user, params, result)
    render_localized_operation_result result
  end
end
