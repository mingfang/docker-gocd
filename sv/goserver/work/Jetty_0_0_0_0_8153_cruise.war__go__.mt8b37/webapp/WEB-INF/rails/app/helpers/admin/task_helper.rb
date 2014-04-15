module Admin
  module TaskHelper
    include JavaImports

    def task_type_from_class(task)
      task.getClass().getSimpleName().gsub(/Task$/, '').downcase
    end

    def task_options
      result = {}
      task_view_service.allTasks().each do |task|
        if (task.getTypeForDisplay() == "Custom Command")
          @last_task=task
        end
        result[task.getTypeForDisplay()] = task.java_class.simple_name unless task.java_class.simple_name == "FetchTask" || task.java_class.simple_name == "ExecTask"
      end
      result["More..."] = @last_task.java_class.simple_name
      result
    end

    def selected_option oncancel_config
      oncancel_config.getTask().getTaskType(); 
    end

    def task_css_class task
      task_name = task_type_from_class task
      case task_name
        when 'exec' then return 'lookup_icon'
        else ''
      end
    end
  end
end