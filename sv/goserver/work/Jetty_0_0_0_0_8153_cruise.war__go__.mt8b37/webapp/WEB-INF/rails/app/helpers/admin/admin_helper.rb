module Admin
  module AdminHelper
    def md5_field
      hidden_field_tag :config_md5, @cruise_config.getMd5()
    end

    def with_md5_param(options)
      {:config_md5 => @cruise_config.getMd5()}.merge(options)
    end

    def current_tab_field value
      hidden_field_tag :current_tab, value
    end

    def tab_aware_job_link(pipeline_name, stage_name, job_name, tab_name)
      if (navigating_from_another_jobs_page_with_a_non_tasks_tab(tab_name))
        admin_job_edit_path(:pipeline_name => pipeline_name, :stage_name => stage_name, :job_name => job_name, :current_tab=> tab_name)  # Retain the current tab selected on the Job edit page
      else
        admin_tasks_listing_path(:pipeline_name => pipeline_name, :stage_name => stage_name, :job_name => job_name, :current_tab=>"tasks") # Defaults to the task listing page when from a non job page
      end
    end

    def navigating_from_job_listing(tab_name)
      tab_name == "jobs"
    end

    def tab_aware_stage_link(pipeline_name, stage_name, tab_name)
      if (navigating_from_another_stages_page && tab_name)
        if (navigating_from_job_listing(tab_name))
          admin_job_listing_path(:pipeline_name => pipeline_name, :stage_name => stage_name, :current_tab=> tab_name) # Retain job listing as current tab on stage edit
        else
          admin_stage_edit_path(:pipeline_name => pipeline_name, :stage_name => stage_name, :current_tab=> tab_name) # Retain tab other than job listing as current tab on stage edit
        end
      else
        admin_stage_edit_path(:pipeline_name =>pipeline_name, :stage_name => stage_name, :current_tab=>"settings") # Default to stage settings for stage edit when from a non stage page
      end
    end

    def default_job_timeout_for_display(cruise_config)
      if (cruise_config.server().getTimeoutType() == com.thoughtworks.cruise.config.ServerConfig::NEVER_TIMEOUT)
        "Never"
      else
        "#{cruise_config.server().getJobTimeout} minute(s)"
      end
    end

    def first_stage_of_template(cruise_config, template_name)
      cruise_config.getTemplateByName(template_name).get(0)
    end

    def postgresql?
      system_environment.isPostgresql()
    end

    private
    def navigating_from_another_jobs_page_with_a_non_tasks_tab(tab_name)
      params[:job_name] && tab_name && tab_name != "tasks"
    end

    def navigating_from_another_stages_page
      (!params[:stage_name].blank?) && params[:job_name].blank?
    end
    
  end
end