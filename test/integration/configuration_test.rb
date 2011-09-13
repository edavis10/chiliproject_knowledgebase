require 'test_helper'

class ConfigurationTest < ActionController::IntegrationTest
  def setup
    @user = User.generate!(:password => 'test', :password_confirmation => 'test', :admin => true)
    @project = Project.generate!.reload
    @project2 = Project.generate!.reload
  end

  should "add a plugin configuration panel" do
    login_as(@user.login, 'test')
    visit_home
    click_link 'Administration'
    assert_response :success

    click_link 'Plugins'
    assert_response :success

    click_link 'Configure'
    assert_response :success
  end

  should "be able to configure the project for the knowledgebase" do
    login_as(@user.login, 'test')
    visit_configuration_panel

    select @project.name, :from => 'Project'
    click_button 'Apply'

    assert_equal @project, ChiliprojectKnowledgebase::Configuration.project
  end

  should "be able to configure the introduction text for the knowledgebase" do
    login_as(@user.login, 'test')
    visit_configuration_panel

    fill_in "Introduction text", :with => "This is an introduction"
    click_button 'Apply'

    assert_equal "This is an introduction", ChiliprojectKnowledgebase::Configuration.introduction_text
  end
end
