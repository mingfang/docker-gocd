module FailuresHelper
  include ParamEncoder

  def esc(string, sequence)
    string.gsub(sequence, sequence * 2)
  end

  def fbh_failure_detail_popup_id_for_failure(job_identifier, test_suite_name, test_case_name)
    "for_fbh_failure_details_#{esc(job_identifier.buildLocator(), '_')}_#{esc(test_suite_name, '_')}_#{esc(test_case_name, '_')}".to_json()
  end

  def failure_details_link(job_id, suite_name, test_name)
    id = fbh_failure_detail_popup_id_for_failure(job_id, suite_name, test_name)
    <<-LINK
<a href='#{failure_details_path(job_id, suite_name, test_name)}' id=#{id} class="fbh_failure_detail_button" title='#{h(l.string("VIEW_FAILURE_DETAILS"))}'>[Trace]</a>
LINK
  end

  def failure_details_path job_id, suite_name, test_name
    failure_details_internal_path(:pipeline_name => job_id.getPipelineName(), :pipeline_counter => job_id.getPipelineCounter(), :stage_name => job_id.getStageName(),
                                  :stage_counter => job_id.getStageCounter(), :job_name => job_id.getBuildName(), :suite_name => enc(suite_name), :test_name => enc(test_name))
  end
end