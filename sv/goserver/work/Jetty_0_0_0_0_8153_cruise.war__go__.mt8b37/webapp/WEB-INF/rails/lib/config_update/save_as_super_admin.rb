module ConfigUpdate
  class SaveAsSuperAdmin < ::ConfigUpdate::SaveAction
    include ::ConfigUpdate::CheckIsSuperAdmin
  end
end