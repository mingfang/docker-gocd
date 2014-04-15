module ConfigUpdate
  module JobTaskSubject
    include ::ConfigUpdate::LoadConfig

    def subject(job)
      load_task(job, task_index)
    end
  end
end