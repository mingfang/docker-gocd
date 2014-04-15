module ComparisonHelper

  def pipeline_compare_href pipeline_name, from_counter, to_counter
    if (from_counter > to_counter)
      return pipeline_compare_href pipeline_name, to_counter, from_counter
    end
    compare_pipelines_path(:pipeline_name => pipeline_name, :from_counter => from_counter, :to_counter => to_counter)
  end

  def any_match?(pattern, *values)
    regex = /#{pattern}/i
    values.compact.any? { |s| s =~ regex }
  end

  def compare_pipeline_pagination_handler page, suffix
    dom_id = "pim_pages_#{page.getLabel()}"
    url = compare_pipelines_timeline_path(:page => page.getNumber(),:other_pipeline_counter => params[:other_pipeline_counter], :suffix => suffix)
    <<END
    <a href="#" id="#{dom_id}">#{page.getLabel()}</a>
    <script type="text/javascript">
        Util.click_load({target: '##{dom_id}', url: '#{url}', update: '#modal_timeline_container', spinnerContainer: 'pagination_bar'});
    </script>
END
  end

  def show_bisect?
    params[:show_bisect] == true.to_s
  end
end