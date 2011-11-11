class GroupsController < ApplicationController
  def index
    @groups = Group.order(:name).all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @groups }
    end
  end

  def show
    @group = Group.includes(bookings: [:teachers, :room, :course, { timeslot: :day }]).find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json {
        render json: @group,
          include: {bookings: {methods: [:teachers, :room, :course, :timeslot]}},
          except: [:created_at, :updated_at]
      }
    end
  end
end
