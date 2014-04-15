import javax.servlet.ServletContext

require 'erb_renderer'

class Spring

  MUTEX = Mutex.new

  def self.bean(bean_name)
    context.get_bean(bean_name)
  rescue
    puts "Error loading bean #{bean_name} : #{$!.to_s}"
    beans = context.bean_definition_names.collect { |bean| bean }
    puts "Defined beans are: #{beans.sort.join(', ')}"
    raise $!
  end

  def self.context
    if (!@context)
      MUTEX.synchronize do
        if (!@context)
          @context =  load_context
          self.bean("viewRenderingService").registerRenderer(com.thoughtworks.cruise.plugins.presentation.Renderer.ERB, ErbRenderer.new) if @context
        end
      end
    end
    @context
  end

  def self.load_context
    org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext($servlet_context)
  end
end
