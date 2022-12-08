class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {errors: ['Invalid username or password']}, status: :unauthorized
        end
    end

    def destroy
        if session[:user_id]
            session[:user_id] = nil
        else
            render json: {errors: ["unautherized"]}, status: :unauthorized
        end
    end
end

