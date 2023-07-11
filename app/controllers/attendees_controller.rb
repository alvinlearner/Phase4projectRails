class AttendeesController < ApplicationController
    
    rescue_from ActiveRecord::RecordInvalid, with:  :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 
    def create
        attendee = Attendee.create!(attendee_params)
        render json: attendee, status: :created
    end

    # GET /attendee
  def index
    attendee = Attendee.all
    render json: attendee
  end

  # GET /attendee/:id
  def show
    attendee = find_attendee
    render json: attendee
  end

  def attendee_count
    statistics = Attendee.all.count
    render json: statistics
  end

  private
  def find_event
    Attendee.find(params[:id])
  end

  def attendee_params
    params.permit(:user_id, :event_id)
  end

  def render_unprocessable_entity(invalid)
    render json:{error: invalid.record.errors}, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: "Attendee not found" }, status: :not_found
  end
end
