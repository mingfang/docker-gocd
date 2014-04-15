class Log4jLogger
  module Severity
    DEBUG   = 0
    INFO    = 1
    WARN    = 2
    ERROR   = 3
    FATAL   = 4
    UNKNOWN = 5
  end
  include Severity

  def self.init_severities_map
    all = {}
    Severity.constants.each do |c|
      all[const_get(c)] = c
    end
    all
  end

  @@severities = init_severities_map
  
  ##
  # :singleton-method:
  # Set to false to disable the silencer
  @@silencer = true

  def self.silencer=(silencer)
    @@silencer = silencer
  end

  def self.silencer
    @@silencer
  end

  # Silences the logger for the duration of the block.
  def silence(temporary_level = ERROR)
    if silencer
      begin
        old_logger_level, self.level = level, temporary_level
        yield self
      ensure
        self.level = old_logger_level
      end
    else
      yield self
    end
  end

  attr_accessor :level

  def initialize(level = DEBUG)
    @level = level
    @logger = org.apache.log4j.Logger.getLogger("com.thoughtworks.cruise.server.Rails");
  end

  def add(severity, message = nil, progname = nil, &block)
    return if @level > severity
    message = (message || (block && block.call) || progname).to_s
    # If a newline is necessary then create a new message ending with a newline.
    # Ensures that the original message is not mutated.
    # message = "#{message}\n" unless message[-1] == ?\n
    @logger.log(to_log4j_level(severity), message)
    message
  end

  for severity in Severity.constants
    class_eval <<-EOT, __FILE__, __LINE__
      def #{severity.downcase}(message = nil, progname = nil, &block)  # def debug(message = nil, progname = nil, &block)
        add(#{severity}, message, progname, &block)                    #   add(DEBUG, message, progname, &block)
      end                                                              # end
                                                                       #
      def #{severity.downcase}?                                        # def debug?
        #{severity} >= @level                                          #   DEBUG >= @level
      end                                                              # end
    EOT
  end

  def close
  end

  protected
  def to_log4j_level(severity)
    org.apache.log4j.Level.toLevel(severity_from(severity), org.apache.log4j.Level::WARN)
  end

  def severity_from(severity)
    @@severities[severity]    
  end
end
