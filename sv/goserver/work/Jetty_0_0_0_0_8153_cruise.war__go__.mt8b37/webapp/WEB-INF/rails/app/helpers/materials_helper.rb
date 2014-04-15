module MaterialsHelper
  def attributes_for_material(material)
    material.getSqlCriteria().inject("") do |s, entry|
      key, value = entry.first, entry.last
      value = material.getUriForDisplay() if key == "url"
      "#{s} #{key}=\"#{h(value)}\""
    end
  end

  def current_modification? modification
    @deployed_revision.isRealRevision() && (modification.getRevision() == @deployed_revision.getRevision())
  end

  def latest_modification? modification
    modification.equals(@modifications.first())
  end

  def has_modification? material  
    material_service.hasModificationFor(material)
  end

  def dependency_material? material
    material.getType() == "DependencyMaterial"
  end

  def stage_url_from_identifier locator
    stage_url(:id => stage_service.findStageIdByLocator(locator))
  end

  def render_simple_comment(comment)
    if comment.match(/\"TYPE\":\"PACKAGE_MATERIAL\"/)
      package_comment_map = package_material_display_comment(comment)
      trackback_url = package_comment_map['TRACKBACK_URL'].blank? ? l.string('NOT_PROVIDED') : package_comment_map['TRACKBACK_URL']
      result = package_comment_map['COMMENT'] || "#{l.string('TRACKBACK')}#{trackback_url}"
      return result
    end
    comment
  end

  def render_comment_markup_for(comment, pipeline_name)
    if comment.match(/\"TYPE\":\"PACKAGE_MATERIAL\"/)
      render_comment_for_package_material(comment)
    else
      render_tracking_tool_link_for_comment(comment, pipeline_name)
    end
  end

  def render_comment(modification, pipeline_name)
    render_comment_markup_for(modification.getComment(),pipeline_name)
  end

  def render_comment_for_package_material(comment)
    package_comment_map = package_material_display_comment(comment)
    "#{get_comment(package_comment_map)}#{l.string('TRACKBACK')}#{get_trackback_url(package_comment_map)}"
  end

  def render_tracking_tool_link(modification, pipeline_name)
    render_tracking_tool_link_for_comment(modification.getComment(), pipeline_name)
  end

  def render_tracking_tool_link_for_comment(comment, pipeline_name)
    comment_renderer = cruise_config_service.getCommentRendererFor(pipeline_name)
    simple_format comment_renderer.render(comment)
  end


  def package_material_display_comment(comment)
    ActiveSupport::JSON.decode(comment)
  end

  def get_comment(comment_map)
    comment_map['COMMENT'].blank? ? "" : "#{comment_map['COMMENT']}<br/>"
  end

  def get_trackback_url(comment_map)
    comment_map['TRACKBACK_URL'].blank? ? l.string('NOT_PROVIDED') : link_to(comment_map['TRACKBACK_URL'], comment_map['TRACKBACK_URL'])
  end

  def material_type_from_class(material)
    material.getClass().getSimpleName().gsub(/MaterialConfig$/, '').downcase
  end

  def admin_material_edit_path(material)
    send("admin_#{material_type_from_class(material)}_edit_path", :finger_print => material.getPipelineUniqueFingerprint())
  end
end