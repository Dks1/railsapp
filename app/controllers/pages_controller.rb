class PagesController < ApplicationController
  
  layout "admin"
  before_action :confirm_loged_in
  before_action :find_subject
  
  def index
    #@pages = Page.where(:subject_id => @subject.id).sorted
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(:subject_id => @subject.id, :name => "Default")
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
  end
  
  def create
    #Instantiate a new object using form parameters
    @page = Page.new(page_params)
    #save the object
    if @page.save
    #If save succeed ,redirect to the index action
    flash[:notice] = "Page created Successfully"
    redirect_to(:action => "index", :subject_id => @subject.id)
    else
    #If save fails ,redisplay the form so user can fix problems
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
    render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
    
  end
  
  def update
    #Find an existing object using form parameters
    @page = Page.find(params[:id])
    #update the object
   if @page.update_attributes(page_params)
    #If update succeed ,redirect to the index action
    flash[:notice] = "Page updated Successfully"
    redirect_to(:action => "show", :id => @page.id, :subject_id => @subject.id)
    else
    #If update fails ,redisplay the form so user can fix problems
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
    render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end
  
  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name}' destroyed Successfully"
    redirect_to(:action => 'index', :subject_id => @subject.id)
  end
  
  private 
  def page_params
    #same as using "params[:subject]", except that it :
    #- raises an error is :subject is not present
    #- allows listed attribute to be mass-assigned
    
    params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible);
  end
  
  def find_subject
    if params[:subject_id]
      @subject = Subject.find(params[:subject_id])
    end
  end
  
end
