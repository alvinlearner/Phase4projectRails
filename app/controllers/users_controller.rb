class UsersController < ApplicationController
    #  Create a new user when signing up
    def register
        user = User.create(user_params)
     if user.valid?
       session[:user_id] = user.id # Save user id in the session
       render json: user, status: :created
     else
       render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
     end

      # Set the CORS headers
    # response.headers['Access-Control-Allow-Origin'] = 'https://events-app-api-mu7z.onrender.com'
    # response.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
    # response.headers['Access-Control-Allow-Headers'] = 'Content-Type'

    end



    
    # Keep user logged in 
    def show
        user = User.find_by(id: session[:user_id])
        if user
          render json: user
        else
          render json: { error: "Not authorized" }, status: :unauthorized
        end
      end

    def count
        users = User.all
        statistics = users.count
        render json: statistics
    end


    def index
        render json: User.all
    end


      # PATCH /users/:id
  def update
    users = find_user
      users.update(profile_params)
      render json: users
     
  end


    private
    def user_params
        params.permit(:username, :password, :password_confirmation, :email, :avatar, :bio)
    end

    def profile_params
        params.permit(:username, :email, :avatar, :bio)
    end


    def find_user
        User.find(params[:id])
      end
    


end
