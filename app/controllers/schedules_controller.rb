class SchedulesController < ApplicationController
  before_filter :load_eager_and_authorize, only: :show
  before_filter :load_and_authorize, except: :show
  # GET /schedules/1
  # GET /schedules/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedule, methods: :bookings }
    end
  end

  # GET /schedules/1/edit
  def edit
  end

  # PUT /schedules/1
  # PUT /schedules/1.json
  def update
    if params[:schedule]
      params[:schedule][:bookings] = Bookings.find(params[:schedule][:bookings])
    else
      params[:schedule][:bookings] = @schedule.bookings
      params[:schedule][:bookings] << Bookings.find(params[:add_bookings])
      params[:schedule][:bookings].reject { |e| params[:remove_bookings].include? e.id }
    end
    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def load_and_authorize
    if current_user.role?(:admin) && params[:user_id]
      @schedule = Schedule.find(params[:user_id])
    else
      @schedule = current_user.schedule
    end
    authorize! params[:action], @schedule
  end
  def load_eager_and_authorize
    if current_user.role?(:admin) && params[:user_id]
      @schedule = Schedule.includes(bookings: [:teachers, :room, :course, :group, { timeslot: :day }]).find(params[:user_id])
    else
      @schedule = Schedule.includes(bookings: [:teachers, :room, :course, :group, { timeslot: :day }]).find(current_user.schedule.id)
    end
    authorize! params[:action], @schedule
  end
end
