class SchedulesController < ApplicationController
  #before_filter :load_eager_and_authorize, only: :show
  #before_filter :load_and_authorize, except: :show
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
      params[:schedule] = {}
      params[:schedule][:bookings] = @schedule.bookings
      params[:schedule][:bookings] << Booking.find(params[:add_bookings]) if params[:add_bookings]
      params[:schedule][:bookings].reject! { |e| params[:remove_bookings].include? e.id.to_s } if params[:remove_bookings]
      params[:schedule][:bookings] = params[:schedule][:bookings].flatten
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
    if params['user_id']
      @schedule = User.find(params['user_id']).schedule
    else
      @schedule = current_user.schedule
    end
    authorize! params[:action].to_sym, @schedule
  end
  def load_eager_and_authorize
    if params['user_id']
      @schedule = Schedule.includes(bookings: [:teachers, :room, :course, :group, { timeslot: :day }]).where(user_id: params['user_id']).first
    else
      @schedule = Schedule.includes(bookings: [:teachers, :room, :course, :group, { timeslot: :day }]).where(user_id: current_user.id).first
    end
    authorize! params[:action].to_sym, @schedule
  end
end
