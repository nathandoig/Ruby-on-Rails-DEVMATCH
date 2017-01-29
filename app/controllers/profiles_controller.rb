class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  # Get to /users/:user_id/profile/new
  def new
    # Render blank profile details form to fill out
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    # Ensure that we have the user who is filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Your Profile has been created!"
      redirect_to user_path ( params[:user_id] )
    else
      render action: :new
    end
  end
  
  # GET to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  # PUT/PATCH to /users/:user_id/profile
  def update
    # Retreive user from the database
    @user = User.find( params[:user_id] )
    # Retrieve that user's profiles
    @profile = @user.profile
    # Mass assign edited profile attributes and save (update)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile has been updated!"
      # Redirect user to their profile page
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      if(@user != current_user)
        flash[:error] = "You cannot edit other user's profiles."
        redirect_to(root_url)
      end
    end
end