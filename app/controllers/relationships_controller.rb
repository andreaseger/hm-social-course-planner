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
    @relationship = Relationship.new(params[:relationship])

    respond_to do |format|
      if @relationship.save
        format.html { redirect_to @relationship, notice: 'Relationship was successfully created.' }
        format.json { render json: @relationship, status: :created, location: @relationship }
      else
        format.html { render action: "new" }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
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
