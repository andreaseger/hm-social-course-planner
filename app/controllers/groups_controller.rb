class GroupsController < ApplicationController
  after_filter :delete_schedule_from_thread, only: :show

  def index
    @groups = Group.order(:name).all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @groups }
    end
  end

  def show
    Thread.current[:current_user_schedule] = current_user.schedule if current_user
    @group = Group.includes(bookings: [:teachers, :room, :course, { timeslot: :day }]).find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json {
        render json: @group,
          include: {bookings: {methods: [:selected, :teachers, :room, :course, :timeslot]}},
          except: [:created_at, :updated_at]
      }
    end
  end

  private

  def delete_schedule_from_thread
    Thread.current[:current_user_schedule] = nil
  end
end
