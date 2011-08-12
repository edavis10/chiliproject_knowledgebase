class KnowledgeBase
  attr_accessor :name
  attr_accessor :description
  attr_accessor :board_id
  attr_accessor :tags
  attr_accessor :source_id
  attr_accessor :source_type

  def initialize(attributes={})
    @name = attributes["name"] || attributes[:name]
    @description = attributes["description"] || attributes[:description]
    @board_id = attributes["board_id"] || attributes[:board_id]
    @tags = attributes["tags"] || attributes[:tags]
    @source_id = attributes["source_id"] || attributes[:source_id]
    @source_type = attributes["source_type"] || attributes[:source_type]
  end

  def errors
    {}
  end

  def source
    # Assumed to be only issue ids
    "##{@source_id}"
  end

  def description_with_tags_and_source
    @description.to_s.dup << "\nTags: #{@tags}" << "\nSource: #{source}"
  end
  
  def to_message
    m = Message.new
    m.author = User.current
    m.subject = @name
    m.content = description_with_tags_and_source
    m.board_id = @board_id
    m
  end
  
end
