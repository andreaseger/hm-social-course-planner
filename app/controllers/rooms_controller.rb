class RoomsController < ApplicationController
  def index
    @timeslots = Timeslot.now
    if @timeslots.empty?
      @rooms = Room.order(:floor)
    else
      @rooms = Room.where('id not in (?)', @timeslots.map {|e| e.rooms }.flatten.uniq.map(&:id)).order(:floor)
    end

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @rooms }
    end
  end
end
