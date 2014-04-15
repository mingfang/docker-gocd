module ModelWithConstructorAcceptingArgs
  def initialize(args)
    args.each do |field, value|
      send("#{field}=", value)
    end
  end
end