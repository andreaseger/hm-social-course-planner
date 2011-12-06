class ProfilesController < ApplicationController
  before_filter :load_and_authorize
  # GET /profiles/1
  # GET /profiles/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to user_path, notice: 'Profile was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def load_and_authorize
    if params['user_id']# && ( current_user.role?(:admin) || can?(params[:action].to_sym, User.find(params['user_id']).profile) )
      @profile = User.find(params['user_id']).profile
    else
      @profile = current_user.profile
    end
    authorize! params[:action].to_sym, @profile
  end
end
