class AccessController < ApplicationController
  
  layout 'admin'
  
  before_action :confirm_loged_in, :except => [:login, :attempt_login, :logout]
  def index
    # Display text and links
  end

  def login
    # Display login form
  end
  
  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(:username => params[:username]).first
      if found_user
        authorize_user = found_user.authenticate(params[:password])
      end
    end
    if authorize_user
      # Mark user as logged in
      session[:user_id] = authorize_user.id
      session[:username] = authorize_user.username
      flash[:notice] = "You are Logged In."
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
  end
  
  def logout
    # Mark user as logged out
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => 'login')
  end
  
end
