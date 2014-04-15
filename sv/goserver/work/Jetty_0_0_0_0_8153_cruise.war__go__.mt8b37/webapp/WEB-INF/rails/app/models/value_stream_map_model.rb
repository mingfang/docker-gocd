class ValueStreamMapModel

  attr_accessor :current_pipeline, :levels, :error

  NODE_TYPE_FOR_PIPELINE = com.thoughtworks.cruise.domain.valuestreammap.DependencyNodeType::PIPELINE.to_s
  NODE_TYPE_FOR_MATERIAL = com.thoughtworks.cruise.domain.valuestreammap.DependencyNodeType::MATERIAL.to_s

  def initialize(vsm, error, localizer, vsm_path_partial = proc do
    ""
  end, stage_detail_path_partial = proc do
    ""
  end)
    if error
      @error = error
    else
      @current_pipeline = vsm.getCurrentPipeline().getName()
      @levels = Array.new
      vsm.getNodesAtEachLevel().each do |nodes|
        level = VSMPipelineDependencyLevelModel.new()
        level.nodes = Array.new
        nodes.each do |node|
          node_type = node.getType().to_s
          if (node_type == NODE_TYPE_FOR_MATERIAL)
            level.nodes << VSMSCMDependencyNodeModel.new(node.getId(), node.getName(), node.getChildren().collect { |child| child.getId() },
                                                         node.getParents().collect { |parent| parent.getId() }, node.getMaterialType().upcase,
                                                         node.getDepth(), node.getMaterialNames(), node.revisions())
          elsif (node_type == NODE_TYPE_FOR_PIPELINE)
            level.nodes << VSMPipelineDependencyNodeModel.new(node.getId(), node.getName(), node.getChildren().collect { |child| child.getId() },
                                                              node.getParents().collect { |parent| parent.getId() }, node_type,
                                                              node.getDepth(), node.revisions(), node.getMessageString(localizer), node.getViewType(), vsm_path_partial, stage_detail_path_partial)
          else
            level.nodes << VSMDependencyNodeModel.new(node.getId(), node.getName(), node.getChildren().collect { |child| child.getId() },
                                                 node.getParents().collect { |parent| parent.getId() }, node_type,
                                                 node.getDepth())
          end
        end
        @levels << level
      end
    end
  end
end

class VSMPipelineDependencyLevelModel
  attr_accessor :nodes
end

class VSMDependencyNodeModel
  attr_accessor :name, :id, :dependents, :parents, :node_type, :depth, :instances, :locator

  def initialize(id, name, dependents, parents, node_type, depth)
    @id = id
    @name = name
    @dependents = dependents
    @parents = parents
    @node_type = node_type
    @depth = depth
    @instances = []
    @locator = ""
  end
end

class VSMPipelineDependencyNodeModel < VSMDependencyNodeModel
  attr_accessor :name, :id, :dependents, :parents, :node_type, :depth, :instances, :locator, :message, :view_type

  def initialize(id, name, dependents, parents, node_type, depth, revisions, message, view_type, pdg_path_partial, stage_detail_path_partial)
    super(id, name, dependents, parents, node_type, depth)

    @instances = revisions.collect { |revision| VSMPipelineInstanceModel.new(name, revision.getLabel(), revision.getCounter(), revision.getStages() || [], pdg_path_partial, stage_detail_path_partial) } unless revisions == nil
    @locator = "/go/tab/pipeline/history/#{name}" if  view_type == nil
    @message = message unless  message == nil
    @view_type = view_type.to_s unless view_type == nil
  end
end

class VSMSCMDependencyNodeModel < VSMDependencyNodeModel
  attr_accessor :name, :id, :dependents, :parents, :node_type, :depth, :material_names, :instances, :locator

  def initialize(id, name, dependents, parents, node_type, depth, material_names, revisions)
    super(id, name, dependents, parents, node_type, depth)

    @material_names = material_names.collect { |material_name| String.new(material_name) } unless material_names.isEmpty()
    @instances = revisions.collect { |revision| VSMSCMMaterialInstanceModel.new(revision) }
  end
end

class VSMPipelineInstanceModel
  attr_accessor :label, :counter, :locator, :stages

  def initialize(name, label, counter, stages, pdg_path_partial, stage_detail_path_partial)
    @label = label
    @counter = counter
    @locator = ""
    @locator = pdg_path_partial.call name, counter unless counter == 0
    @stages = stages.collect { |stage| VSMPipelineInstanceStageModel.new(stage.getName(), stage.getState().to_s, stage.getCounter(), name, counter, stage_detail_path_partial) }
  end
end

class VSMSCMMaterialInstanceModel
  include RailsLocalizer

  attr_accessor :revision, :user, :comment, :modified_time

  def initialize(revision)
    @revision = revision.getRevisionString
    @user = revision.getUser
    @comment = revision.getComment()
    @modified_time=com.thoughtworks.cruise.util.TimeConverter.convert(revision.getModifiedTime).default_message
  end
end

class VSMPipelineInstanceStageModel
  attr_accessor :name, :status, :locator

  def initialize(name, status, counter, pipeline_name, pipeline_counter, stage_detail_path_partial)
    @name = name
    @status = status
    @locator = ""
    @locator = stage_detail_path_partial.call pipeline_name, pipeline_counter, name, counter unless com.thoughtworks.cruise.domain.StageState::Unknown.to_s == status
  end
end
