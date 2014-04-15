module ConfigUpdate
  module RefsAsUpdatedRefs
    include ::ConfigUpdate::NodeAsUpdatedNode
    include ::ConfigUpdate::SubjectAsUpdatedSubject
  end
end