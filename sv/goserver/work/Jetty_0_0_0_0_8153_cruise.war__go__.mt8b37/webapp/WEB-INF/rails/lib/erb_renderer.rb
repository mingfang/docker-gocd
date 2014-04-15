class ErbRenderer
  include com.thoughtworks.cruise.plugins.presentation.Renderer

  def render(task_view_model, context)
    rb_hash = {}
    context.each do |key, val|
      rb_hash[key] = val
    end
    context[:view].render(:file => "#{task_view_model.getTemplatePath()}", :locals => rb_hash)
  end
end