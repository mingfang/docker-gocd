class Api::AdminController < Api::ApiController
  def start_backup
    result = HttpLocalizedOperationResult.new
    backup_service.startBackup(current_user, result)
    render_localized_operation_result(result)
  end
end
