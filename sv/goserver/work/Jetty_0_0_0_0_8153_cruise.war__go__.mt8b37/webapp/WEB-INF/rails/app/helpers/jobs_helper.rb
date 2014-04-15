module JobsHelper

  def is_test_artifact artifact_plan
    com.thoughtworks.cruise.domain.ArtifactType::unit == artifact_plan.getArtifactType() 
  end
end