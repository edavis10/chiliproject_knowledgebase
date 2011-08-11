module ChiliprojectKnowledgebase
  module Hooks
    class ViewIssuesHistoryJournalBottomHook < Redmine::Hook::ViewListener
      def view_issues_history_journal_bottom(context={})
        journal_id = context[:journal].id
        link = link_to("Knowledge base", {:controller => 'welcome'}, :id => "add-knowledgebase-#{journal_id}", :class => 'icon icon-add knowledgebase-lightbox')
        html = <<JS
<script type='text/javascript'>
$$('#change-#{journal_id} h4 .journal-link').first().insert({ top: '#{link} | '});
</script>
JS
        return html
      end
    end
  end
end

