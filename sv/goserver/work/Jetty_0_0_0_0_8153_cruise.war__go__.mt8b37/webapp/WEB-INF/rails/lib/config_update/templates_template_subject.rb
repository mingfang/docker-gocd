module ::ConfigUpdate
  module TemplatesTemplateSubject
    include ::ConfigUpdate::LoadConfig
    def subject(templates)
      templates.templateByName(CaseInsensitiveString.new(template_name))
    end
  end
end