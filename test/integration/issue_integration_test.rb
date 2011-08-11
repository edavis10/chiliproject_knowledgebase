require 'test_helper'

class IssueIntegrationTest < ActionController::IntegrationTest
  def setup
    @user = User.generate!(:password => 'test', :password_confirmation => 'test', :admin => true).reload
    @project = Project.generate!.reload
    @issue = Issue.generate_for_project!(@project)
    @issue.init_journal(@user, "An update")
    assert_difference("Journal.count") do
      assert @issue.save
    end
    @journal = @issue.journals.last
    login_as(@user.login, 'test')
    visit_home
  end

  should "add a link to each journal entry via JavaScript" do
    visit_issue_page(@issue)
    assert_response :success

    assert find("script[type='text/javascript']", :text => /knowledgebase-lightbox/)
  end
end
