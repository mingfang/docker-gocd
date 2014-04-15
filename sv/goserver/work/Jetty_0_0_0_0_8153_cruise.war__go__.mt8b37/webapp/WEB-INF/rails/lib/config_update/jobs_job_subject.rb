module ConfigUpdate
  module JobsJobSubject
    include ::ConfigUpdate::LoadConfig

    def subject(jobs)
      jobs.getJob(job_name)
    end
  end
end