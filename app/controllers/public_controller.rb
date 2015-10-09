class PublicController < ApplicationController
  
  layout 'public'
  before_action :set_up_navigation
  def index
    # intro text
  end

  def show
    @page = Page.where(:permalink => params[:permalink], :visible => true).first
    if @page.nil?
      redirect_to(:action => 'index')
    else
      # display the page content using show.html.erb 
    end
  end
  
  private 
  
  def set_up_navigation
    @subjects = Subject.visible.sorted
  end
  
end
