ActionView::Helpers::InstanceTag.class_eval do

  unless @go_enhancement_loaded
    def add_default_name_and_id_with_id_omission(options)
      add_default_name_and_id_without_id_omission(options)
      options.delete("omit_id_generation") && options.delete("id")
    end

    alias_method_chain :add_default_name_and_id, :id_omission

    def to_check_box_tag_with_optional_hidden_field(options = {}, *args)
      drop_hidden_field = options.delete(:drop_hidden_field)
      checkbox = to_check_box_tag_without_optional_hidden_field(options, *args)
      if drop_hidden_field
        checkbox.gsub!(/^<input[^>]+?\/>/, '')
      end
      checkbox
    end

    alias_method_chain :to_check_box_tag, :optional_hidden_field

    @go_enhancement_loaded = true
  end
end