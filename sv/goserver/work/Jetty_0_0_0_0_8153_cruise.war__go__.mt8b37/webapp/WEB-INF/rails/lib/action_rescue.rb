module ActionRescue
  def rescue_action(exception)
    RAILS_DEFAULT_LOGGER.error(format_exception(exception))
    if exception.is_a?(ActionController::InvalidAuthenticityToken)
      logger.error("REQUEST: #{request.inspect} SESSION: #{session.inspect} REQUEST_OBJECT_ID: #{request.object_id} SESSION_OBJECT_ID: #{session.object_id}") if ENV['LOG_REQUEST_AND_SESSION_FOR_INVALID_AUTH_TOKEN']
      redirect_to root_url
      return
    end
    render_error_template l.string("INTERNAL_SERVER_ERROR"), 500
  end

  def format_exception(exception)
    "#{exception}\n#{stacktrace_for(exception)}"
  end

  def stacktrace_for(exception)
    if exception.is_a?(org.jruby.NativeException)
      collect_stacktrace {|print_writer| exception.printBacktrace(print_writer) }
    elsif exception.is_a?(java.lang.Throwable)
      collect_stacktrace {|print_writer| exception.printStackTrace(print_writer) }
    elsif exception.respond_to?(:backtrace)
      exception.backtrace.join("\n")
    else
      "could not extract stacktrace from exception: #{exception.class} (#{exception})"
    end
  end

  def collect_stacktrace
    java.io.StringWriter writer = java.io.StringWriter.new();
    yield print_writer
    return writer.getBuffer().toString();
  end
end