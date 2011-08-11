KnowledgeBase = Struct.new(:name,
                           :description,
                           :board_id,
                           :tags)

class KnowledgeBase
  def errors
    {}
  end
end
