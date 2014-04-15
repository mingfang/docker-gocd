module ConfigUpdate
  class SaveAsPipelineOrTemplateAdmin < ::ConfigUpdate::SaveAction
    include ::ConfigUpdate::CheckCanEditPipelineOrTemplate
  end
end