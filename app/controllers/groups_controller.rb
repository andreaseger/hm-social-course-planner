class GroupsController < ApplicationController
  def index
    @groups = Group.order(:name).limit(per_page)
    @groups = @groups.offset((params[:page].to_i-1)*per_page) if params[:page].present?

    respond_to do |format|
      format.html # index.html.haml
      format.json do
        render json: @groups.map { |g| view_context.group_for_mustache(g) }
      end
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

private
  def per_page
    10
  end
end
