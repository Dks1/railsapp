class SubjectsController < ApplicationController
  
  layout "admin"
  before_action :confirm_loged_in
  
  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new(:name => "Default")
    @subject_count = Subject.count + 1
  end

  def create
    #Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    #save the object
    if @subject.save
    #If save succeed ,redirect to the index action
    flash[:notice] = "Subject created Successfully"
    redirect_to(:action => "index")
    else
    #If save fails ,redisplay the form so user can fix problems
    @subject_count = Subject.count + 1
    render('new')
    end
  end
  
  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    #Find an existing object using form parameters
    @subject = Subject.find(params[:id])
    #update the object
   if @subject.update_attributes(subject_params)
    #If update succeed ,redirect to the index action
    flash[:notice] = "Subject updated Successfully"
    redirect_to(:action => "show", :id => @subject.id)
    else
    #If update fails ,redisplay the form so user can fix problems
    @subject_count = Subject.count
    render('edit')
    end
  end
  
  def delete
     @subject = Subject.find(params[:id])
  end
  
  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed Successfully"
    redirect_to(:action => 'index')
  end
  
  private 
  def subject_params
    #same as using "params[:subject]", except that it :
    #- raises an error is :subject is not present
    #- allows listed attribute to be mass-assigned
    
    params.require(:subject).permit(:name, :position, :visible, :created_at);
  end
end
