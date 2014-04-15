module ConfigUpdate
  class SaveAsGroupAdmin < ::ConfigUpdate::SaveAction
    include ::ConfigUpdate::CheckIsGroupAdmin
  end
end