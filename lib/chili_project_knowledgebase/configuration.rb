module ChiliProjectKnowledgebase
  class Configuration

    def self.settings
      Setting.plugin_chiliproject_knowledgebase || {}
    end
    
    def self.project_id
      settings["project_id"]
    end

    def self.project
      if project_id
        Project.find(project_id)
      end
    end
  end
end
