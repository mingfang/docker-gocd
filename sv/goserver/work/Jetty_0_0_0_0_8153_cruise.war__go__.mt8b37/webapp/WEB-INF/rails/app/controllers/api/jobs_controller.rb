include_class 'org.springframework.dao.DataRetrievalFailureException'

class Api::JobsController < Api::ApiController
  include ApplicationHelper

  def render_not_found()
    render :text => "Not Found!", :status => 404
  end

  def index
    return render_not_found unless number?(params[:id])
    job_id = Integer(params[:id])
    begin
      @doc = xml_api_service.write(JobXmlViewModel.new(job_instance_service.buildById(job_id)), "#{request.protocol}#{request.host_with_port}/go")
    rescue Exception => e
      logger.error(e)
      return render_not_found
    end
  end

  def scheduled
    scheduled_waiting_jobs = job_instance_service.waitingJobPlans()
    @doc = xml_api_service.write(JobPlanXmlViewModel.new(scheduled_waiting_jobs), "#{request.protocol}#{request.host_with_port}/go")
  end
end
