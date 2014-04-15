module ParamEncoder
  module ClassMethods
    def decode_params *param_names
      options = param_names.extract_options!
      prepend_before_filter(options) do |controller|
        params = controller.params
        param_names.each do |param_name|
          params[param_name] = controller.dec(params[param_name])
        end
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def enc str
    CGI.escape(Base64.encode64(str))
  end

  def dec str
    Base64.decode64(CGI.unescape(str))
  end
end