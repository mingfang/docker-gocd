class TopLevelFormNameProvider
  include com.thoughtworks.cruise.plugins.presentation.FormNameProvider

  def initialize(name)
    @object_name = name
  end

  def name(actual_name)
    "#{@object_name}[#{actual_name}]"
  end

  def collection(actual_name)
    TopLevelFormNameProvider.new(name(actual_name) + "[]")
  end

  def obj(actual_name)
    TopLevelFormNameProvider.new(name(actual_name))
  end
end