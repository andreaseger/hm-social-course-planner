class RelationshipsController < ApplicationController
  def index
    @relationships = Relationship.all
    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @relationships }
    end
  end

  def show
    @relationship = Relationship.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @relationship }
    end
  end

  def new
    @relationship = Relationship.new(user: current_user)
  end

  def create
    respond_to do |format|
      if current_user.add_classmate(User.find(params[:relationship]["classmate_id"]))
        format.html { redirect_to user_path, notice: 'Relationship was successfully created.' }
        format.json { render json: Relationship.where(user_id: current_user.id).last, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: "some errors", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy

    respond_to do |format|
      format.html { redirect_to relationships_url }
      format.json { head :ok }
    end
  end

end
