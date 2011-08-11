require 'test_helper'

class KnowledgeBasesTest < ActionController::IntegrationTest
  def setup
    @user = User.generate!(:password => 'test', :password_confirmation => 'test').reload
    @project = Project.generate!.reload
    configure_plugin('project_id' => @project.id)
    @issue = Issue.generate_for_project!(@project)
    @issue.init_journal(@user, "An update note")
    assert_difference("Journal.count") do
      assert @issue.save
    end
    @journal = @issue.journals.last
    login_as(@user.login, 'test')
    visit_home
  end

  context "form" do
    context "with permission to add messages to the target forum" do
      setup do
        @role = Role.generate!(:permissions => [:view_issues, :edit_issues, :view_messages, :add_messages])
        User.add_to_project(@user, @project, @role)
        visit "/knowledge_bases/new?format=js&journal_id=#{@journal.id}"
      end
      
      should "render an html snippet" do
        assert find('div')
      end
      
      should "have a form that posts to the KnowledgeBase" do
        assert find('form#knowledgebase-form')
      end
      
      should "have a name field" do
        assert find_field("knowledge_base[name]")
      end
      
      should "have a description field" do
        assert find("textarea#knowledge_base_description")
      end
      
      should "populate the description field from the journal notes" do
        assert_equal "An update note", find("#knowledge_base_description").value
      end

      should "have a field to select which forum to use" do
        assert find_field("knowledge_base[board_id]")
      end

      should "have a field for tags" do
        assert find_field("knowledge_base[tags]")
      end
    end

    context "without permission to add messages to the target forum" do
      setup do
        @role = Role.generate!(:permissions => [:view_issues, :edit_issues])
        User.add_to_project(@user, @project, @role)
        visit "/knowledge_bases/new?format=js&journal_id=#{@journal.id}"
      end

      should "return HTTP 403" do
        assert_response 403
      end
    end

  end
end
