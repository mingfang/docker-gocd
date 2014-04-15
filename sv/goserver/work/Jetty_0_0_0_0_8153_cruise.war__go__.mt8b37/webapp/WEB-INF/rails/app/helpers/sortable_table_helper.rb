module SortableTableHelper
  def table_sort_params column
    options = { :column => column, :order => 'ASC', :filter => params[:filter]}
    options.merge!(:order => 'DESC') if (params[:column] == column) && (params[:order] == 'ASC')
    options
  end

  def sortable_column_status column
    return { } unless column == params[:column]
    {:class => "sorted_#{params[:order].downcase}"}
  end

  def surround_with_span span_text
    "<span>#{span_text}</span>"
  end

  def column_header(name, param_name, sortable = true)
    sortable ? link_to(surround_with_span(name), table_sort_params(param_name), sortable_column_status(param_name)) : surround_with_span(name)
  end
end