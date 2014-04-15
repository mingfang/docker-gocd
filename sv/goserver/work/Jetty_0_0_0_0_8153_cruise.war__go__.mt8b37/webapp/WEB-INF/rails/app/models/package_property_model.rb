class PackagePropertyModel
  attr_accessor :display_name, :value, :name, :is_mandatory, :is_secure

  def initialize(package_configuration, config_property)
    @display_name = package_configuration.getOption(com.thoughtworks.go.plugin.access.packagematerial.PackageConfiguration::DISPLAY_NAME).to_s.empty? ? package_configuration.getKey() : package_configuration.getOption(com.thoughtworks.go.plugin.access.packagematerial.PackageConfiguration::DISPLAY_NAME)
    @is_mandatory = package_configuration.getOption(com.thoughtworks.go.plugin.access.packagematerial.PackageConfiguration::REQUIRED)
    @is_secure = package_configuration.getOption(com.thoughtworks.go.plugin.access.packagematerial.PackageConfiguration::SECURE)
    if config_property
      if (@is_secure)
        @value = config_property.getEncryptedValue().getValue()
      else
        @value = config_property.getConfigurationValue().getValue()
      end
    end
    @name = package_configuration.getKey()
  end
end
