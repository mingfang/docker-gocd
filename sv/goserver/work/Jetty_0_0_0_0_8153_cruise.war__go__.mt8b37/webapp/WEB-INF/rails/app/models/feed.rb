class Feed

  def initialize(user, service, operation_result, params = {})
    if params.has_key?(:before)
      @entries = service.feedBefore(user, params[:before].to_i, operation_result)
    else
      @entries = service.feed(user, operation_result)
    end
  end

  def updated_date
    @updated_date = @entries.lastUpdatedDate().iso8601
  end

  def entries
    @entries
  end

  def first
    @entries.firstEntryId()
  end

  def last
    @entries.lastEntryId()
  end

end
