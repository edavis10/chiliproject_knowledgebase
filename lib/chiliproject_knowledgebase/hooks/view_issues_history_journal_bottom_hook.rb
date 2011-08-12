module ChiliprojectKnowledgebase
  module Hooks
    class ViewIssuesHistoryJournalBottomHook < Redmine::Hook::ViewListener
      def view_issues_history_journal_bottom(context={})
        journal_id = context[:journal].id
        link = content_tag(:a, image_tag("book_add.png", :plugin => 'chiliproject_knowledgebase'), :href => '#', :id => "add-knowledgebase-#{journal_id}", :class => 'knowledgebase-lightbox', :title => l(:text_knowledgebase_add))
        html = <<JS
<script type='text/javascript'>
$$('#change-#{journal_id} h4 .journal-link').first().insert({ top: ' #{link} '});
</script>
JS
        return html
      end
    end
  end
end

