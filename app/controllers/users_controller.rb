class UsersController < ApplicationController
  before_filter :load_and_authorize, except: :index
  #def index
  #  @users = User.all
  #  authorize! :index, User

  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.json { render json: @user }
  #  end
  #end


  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end

private
  def load_and_authorize
    if current_user.role?(:admin) && params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    authorize! params[:action], @user
  end
end
