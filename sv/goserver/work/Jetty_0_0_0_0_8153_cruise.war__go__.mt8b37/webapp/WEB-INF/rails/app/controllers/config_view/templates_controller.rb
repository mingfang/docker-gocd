module ConfigView
  class TemplatesController < ConfigView::ConfigViewController

    def show
      result = HttpLocalizedOperationResult.new
      @template_config = template_config_service.loadForView(params[:name], result)
      render_localized_operation_result(result) unless result.isSuccessful()
    end
  end
end
