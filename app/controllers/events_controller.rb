class EventsController < ApplicationController
    
    rescue_from ActiveRecord::RecordInvalid, with:  :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 

  # GET /events
  def index
    events = Event.all
    render json: events
  end

  # POST /events
  def create
    events = Event.create!(event_params)
    render json: events, status: :created
  end

  # GET /events/:id
  def show
    events = find_event
      render json: events 
           
  end

  # PATCH /eventss/:id
  def update
    events = find_event
      events.update(event_params)
      render json: events
   
      
  end



  # DELETE /events/:id
  def destroy
    events = find_event
    events
    events.destroy
    head :no_content
    
  end

  def count
    statistics = Event.all.count
    render json: statistics
  end

  def category_count
    event_counts = Event.group(:category).count
    render json: event_counts
  end

  def date_count
    event_counts = Event.group(:date).count
    render json: event_counts
  end

  private


  def render_unprocessable_entity(invalid)
    render json:{error: invalid.record.errors}, status: :unprocessable_entity
  end

  def event_params
    params.permit(:name, :description, :image,:venue,:date,:category)
  end


  def render_not_found_response
    render json: { error: "Events not found" }, status: :not_found
  end

  def find_event
    Event.find(params[:id])
  end

end

