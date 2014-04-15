module ConfigView
  class ConfigViewController < ::ApplicationController
    before_filter :enable_admin_error_template

    def enable_admin_error_template
      self.error_template_for_request = 'shared/config_error'
    end
  end
end