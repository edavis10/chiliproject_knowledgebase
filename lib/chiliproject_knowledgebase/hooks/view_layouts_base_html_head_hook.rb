module ChiliprojectKnowledgebase
  module Hooks
    class ViewLayoutsBaseHtmlHeadHook < Redmine::Hook::ViewListener
      render_on(:view_layouts_base_html_head, :partial => 'knowledgebase/html_head', :layout => false)
    end
  end
end
