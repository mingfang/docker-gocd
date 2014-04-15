class Object
  def breakpoint
  end
end

if Rails.env.development?
  class Object
    def breakpoint
      puts "Welcome to the JRuby \"debugger\""
      print "> "
      while true
        cmd = STDIN.readline.strip
        break if cmd =~ /^(END|QUIT|STOP|CONT|CONTINUE)$/
        begin
          result = eval cmd
          puts "=> #{result.inspect}"
        rescue => e
          puts "Error: #{e.inspect}\n#{e.backtrace.collect {|line| "  " + line}}"
        end if cmd !~ /^\s*$/
        print "> "
      end
    end
  end
end