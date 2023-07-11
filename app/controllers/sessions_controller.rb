# class SessionsController < ApplicationController
#     # Create a session to hold user info when loging in and authenticate user
#     def create
#         user = User.find_by(username: params[:username])
#         if user&.authenticate(params[:password])
#           session[:user_id] = user.id
#           session[:username] = user.username
#           session[:email] = user.email
#           render json: user, status: :created
#         else
#           render json: { error: "Invalid username or password" }, status: :unauthorized
#         end
#     end

#     # Remove user details from sessions when logging out


#     def destroy
#       session.delete :user_id
#       head :no_content
#     end
# end

class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { errors: ["Invalid username or password"] }, status: :unauthorized
      end
    end

    def destroy
        unless session[:user_id]
          render json: { errors: ["Not logged in"] }, status: :unauthorized
          return
        end
    
        session.delete(:user_id)
        head :no_content
    end
end
