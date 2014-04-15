module ConfigUpdate
  module PipelineMaterialSubject
    def subject(pipeline)
      pipeline.materialConfigs().getByFingerPrint(params[:finger_print])
    end
  end
end