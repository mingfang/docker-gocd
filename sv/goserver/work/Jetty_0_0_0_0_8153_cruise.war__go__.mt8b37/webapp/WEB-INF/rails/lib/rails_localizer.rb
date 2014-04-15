module RailsLocalizer
  class L
    def method_missing method, *params
      com.thoughtworks.cruise.i18n.LocalizedMessage.send(method, *params).localize(Spring.bean("localizer"))
    end
  end

  def l
    L.new
  end
end