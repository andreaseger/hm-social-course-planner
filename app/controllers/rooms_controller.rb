class RoomsController < ApplicationController
  def index
    @rooms = Room.order(:floor).all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @rooms }
    end
  end
end
