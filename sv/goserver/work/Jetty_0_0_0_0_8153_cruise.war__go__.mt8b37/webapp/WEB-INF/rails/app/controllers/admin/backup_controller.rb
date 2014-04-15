class Admin::BackupController < ApplicationController

  layout "admin"

  def index
    @tab_name = "backup"
    @backup_location = backup_service.backupLocation()
    @last_backup_time = backup_service.lastBackupTime()
    @last_backup_user = backup_service.lastBackupUser()
    @available_disk_space_on_artifacts_directory = backup_service.availableDiskSpace()
  end

  def perform_backup
    backup_service.startBackup(current_user, op_result = HttpLocalizedOperationResult.new())
    redirect_with_flash(op_result.message(Spring.bean("localizer")), :action => :index, :class => op_result.isSuccessful() ? "success" : "error")
  end






end