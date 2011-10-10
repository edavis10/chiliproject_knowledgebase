require 'redmine'

Redmine::Plugin.register :chiliproject_knowledgebase do
  name 'Knowledgebase'
  author 'Eric Davis of Little Stream Software'
  description 'An easy way to capture knowledge you are already creating in ChiliProject/Redmine and make it easier to discover and share.'
  url 'https://projects.littlestreamsoftware.com/projects/chiliproject_knowledgebase'
  author_url 'http://www.littlestreamsoftware.com'

  version '0.1.0'

  settings(:partial => 'settings/knowledgebase',
           :default => {
             :project_id => '',
             :introduction_text => ''
           })
end
require 'chiliproject_knowledgebase/hooks/view_issues_history_journal_bottom_hook'
require 'chiliproject_knowledgebase/hooks/view_layouts_base_html_head_hook'
require 'chiliproject_knowledgebase/hooks/view_layouts_base_body_bottom_hook'
