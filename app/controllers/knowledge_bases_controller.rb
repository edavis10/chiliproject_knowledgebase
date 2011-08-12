class KnowledgeBasesController < ApplicationController
  unloadable
  before_filter :require_configuration
  before_filter :authorize
  before_filter :find_journal
  
  def new
    @knowledge_base = KnowledgeBase.new(:source_type => 'issue', :source_id => @issue.id)
    @knowledge_base.description = @journal.notes if @journal.present?
    render :layout => false
  end

  def create
    @knowledge_base = KnowledgeBase.new(params[:knowledge_base])
    @message = @knowledge_base.to_message

    respond_to do |format|
      if @message.save
        format.js { render :json => @message, :layout => false, :status => :created, :location => url_for(:controller => 'messages', :action => 'show', :board_id => @message.board_id, :id => @message.id) }
      else
        format.js { render :json => {:errors => @message.errors.full_messages}, :layout => false, :status => :unprocessable_entity}
      end
    end
    
    
  end

  private
  def find_journal
    begin
      @journal = Journal.find(params[:journal_id])
      @issue = Issue.visible.find_by_id(@journal.journalized_id)
      # Issue isn't visible, so the journal shouldn't be shown
      if @issue.blank?
        @journal = nil
      end
    rescue ActiveRecord::RecordNotFound
      @journal = nil
    end
  end

  def require_configuration
    ChiliprojectKnowledgebase::Configuration.project?
  end
  
  def authorize
    if User.current.allowed_to?(:add_messages, ChiliprojectKnowledgebase::Configuration.project)
      # allowed
    else
      render_403
    end
  end
  
end
