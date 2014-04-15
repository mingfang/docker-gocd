class PackageViewModel
  include RailsLocalizer
  attr_accessor :properties, :name

  def initialize(metadata, package)
    @properties = []
    if(package)
      @name = package.getName()
      return if metadata.nil?
      package_configurations = metadata.list()
      package_configurations.each do |config|
        property = package.getConfiguration().getProperty(config.getKey())
        @properties << PackagePropertyModel.new(config, property)
      end
    end
  end

  def filterSecureProperties!
    @properties.reject! { |x| x.is_secure }
    self
  end
end