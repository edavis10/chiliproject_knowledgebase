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

  context "creating" do
    context "with permission to add messages to the target forum" do
      setup do
        @board = Board.generate!(:project => @project)
        @role = Role.generate!(:permissions => [:view_issues, :edit_issues, :view_messages, :add_messages])
        User.add_to_project(@user, @project, @role)
        User.current = @user
        @post_request = Proc.new {
          page.driver.post "/knowledge_bases/", :format => "js", :knowledge_base => {
            :board_id => @board.id.to_s,
            :name => "This is an example",
            :description => "This is a description",
            :tags => "tag1, tag2",
            :source_id => @issue.id.to_s,
            :source_type => "Issue"
          }
        }
      end

      should "have a HTTP 201 created response" do
        @post_request.call
        assert_response 201
      end
      
      should "create a message" do
        assert_difference("Message.count") do
          @post_request.call
        end
      end
      
      should "use the board id" do
        @post_request.call
        message = Message.last
        assert_equal @board, message.board
      end
      
      should "use the description" do
        @post_request.call
        assert_match /This is a description/, Message.last.content
      end
      
      should "add the tags to the bottom of the content" do
        @post_request.call
        assert_match /Tags: tag1, tag2/, Message.last.content
      end

      should "add a source url to the content" do
        @post_request.call
        assert_match /Source: \##{@issue.id}/, Message.last.content
      end
      
      should "include a location field for where the object is created"
      
    end
  
    context "with permission to add messages to the target forum, with missing data" do
      setup do
        @board = Board.generate!(:project => @project)
        @role = Role.generate!(:permissions => [:view_issues, :edit_issues, :view_messages, :add_messages])
        User.add_to_project(@user, @project, @role)
        User.current = @user
        @post_request = Proc.new {
          page.driver.post "/knowledge_bases/", :format => "js", :knowledge_base => {
            :description => "This is a description",
            :tags => "tag1, tag2",
            :source_id => @issue.id.to_s,
            :source_type => "Issue"
          }
        }
      end

      should "have a HTTP 422 forbidden response" do
        @post_request.call
        assert_response 422
      end
      
      should "list the errors" do
        @post_request.call
        assert has_content?("Board can't be blank")
        assert has_content?("Subject can't be blank")
      end
    end

    context "without permission to add messages to the target forum" do
      setup do
        @board = Board.generate!(:project => @project)
        @role = Role.generate!(:permissions => [:view_issues, :edit_issues])
        User.add_to_project(@user, @project, @role)
        User.current = @user
        @post_request = Proc.new {
          page.driver.post "/knowledge_bases/", :format => "js", :knowledge_base => {}
        }

      end

      should "have a HTTP 403 forbidden response" do
        @post_request.call
        assert_response 403
      end
    end
  end

end
