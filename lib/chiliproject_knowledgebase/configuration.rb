module ChiliprojectKnowledgebase
  class Configuration

    def self.settings
      Setting.plugin_chiliproject_knowledgebase || {}
    end

    def self.introduction_text
      settings["introduction_text"] || ""
    end
    
    def self.project_id
      settings["project_id"]
    end

    def self.project
      if project_id.present?
        Project.find(project_id)
      end
    end

    def self.project?
      project_id.present? && Project.find_by_id(project_id)
    end
  end
end
