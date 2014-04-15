Java::JavaUtil::Date.class_eval do
  def iso8601
    Time.at(self.getTime()/1000).iso8601
  end

  def display_time
    com.thoughtworks.cruise.util.TimeConverter.convert(self);
  end

  def to_long_display_date_time
    pattern = java.text.SimpleDateFormat.new("dd MMM, yyyy 'at' HH:mm:ss [Z]" )
    pattern.format(self)
  end
end
