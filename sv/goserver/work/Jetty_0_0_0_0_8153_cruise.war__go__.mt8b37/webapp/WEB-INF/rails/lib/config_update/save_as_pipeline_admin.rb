module ConfigUpdate
  class SaveAsPipelineAdmin < ::ConfigUpdate::SaveAction
    include ::ConfigUpdate::CheckCanEditPipeline
  end
end