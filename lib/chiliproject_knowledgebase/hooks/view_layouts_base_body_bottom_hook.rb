module ChiliprojectKnowledgebase
  module Hooks
    class ViewLayoutsBaseBodyBottomHook < Redmine::Hook::ViewListener
      def view_layouts_base_body_bottom(context={})
        return "<div id='dialog-window' style='display:none'></div>"
      end
    end
  end
end
