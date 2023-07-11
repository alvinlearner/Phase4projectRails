class PostsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with:  :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response 

  # GET /post
  def index
    post = Post.all
    render json: post
  end

  # POST /post
  def create
    post = Post.create!(Post_params)
    render json: post, status: :created
  end

  # GET /post/:id
  def show
    post = find_Post
    render json: post       
  end

  private
  def render_unprocessable_entity(invalid)
    render json:{error: invalid.record.errors}, status: :unprocessable_entity
  end

  def post_params
    params.permit(:post, :event_id, :user_id)
  end


  def render_not_found_response
    render json: { error: "Post not found" }, status: :not_found
  end

  def find_event
    Event.find(params[:id])
  end
end
