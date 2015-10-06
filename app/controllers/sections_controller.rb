class SectionsController < ApplicationController
  
  layout "admin"
  before_action :confirm_loged_in
  before_action :find_page
  
  def index
    #@sections = Section.where(:page_id => @page.id).sorted
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new(:page_id => @page.id, :name => "Default")
    #@pages = Section.order('position ASC')
    @pages = @page.subject.pages.sorted
    @section_count = Section.count + 1
  end

  def create
    #Instantiate a new object using form parameters
    @section = Section.new(section_params)
    #save the object
    if @section.save
    #If save succeed ,redirect to the index action
    flash[:notice] = "Section created Successfully"
    redirect_to(:action => "index", :page_id => @page.id)
    else
    #If save fails ,redisplay the form so user can fix problems
    @pages = Section.order('position ASC')
    @section_count = Section.count
    render('new')
    end
  end
  
  def edit
   @section = Section.find(params[:id])
   @pages = Page.order('position ASC')
   @section_count = Section.count
  end

  def update
    #Find an existing object using form parameters
    @section = Section.find(params[:id])
    #update the object
   if @section.update_attributes(section_params)
    #If update succeed ,redirect to the index action
    flash[:notice] = "Section updated Successfully"
    redirect_to(:action => "show", :id => @section.id, :page_id => @page.id)
    else
    #If update fails ,redisplay the form so user can fix problems
    @pages = Section.order('position ASC')
    @section_count = Section.count
    render('edit')
    end
  end
  
  def delete
     @section = Section.find(params[:id])
  end
  
  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section '#{section.name}' destroyed Successfully"
    redirect_to(:action => 'index', :page_id => @page.id)
  end
  
  private 
  def section_params
    #same as using "params[:subject]", except that it :
    #- raises an error is :subject is not present
    #- allows listed attribute to be mass-assigned
    
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content);
  end
  
  def find_page
    if params[:page_id]
      @page = Page.find(params[:page_id])
    end
  end
  
end
