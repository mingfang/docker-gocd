com.thoughtworks.cruise.util.Pair.class_eval do
  def to_ary
    [self.first(), self.last()]
  end
end