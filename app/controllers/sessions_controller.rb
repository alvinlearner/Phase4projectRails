class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      # Include the user's authentication token in the JSON response if applicable
      auth_token = user.authentication_token if user.respond_to?(:authentication_token)
      render json: { user: user, auth_token: auth_token }, status: :created
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
