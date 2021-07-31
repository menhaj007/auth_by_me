class UsersController < ApplicationController
    def create
        new_user = User.create(user_params)
        if new_user
            session[:user_id] = new_user.id
            render json: new_user, status: :created
        else
            render json: {error: new_user.errors.full_messages}, status: :unprocessable_entity
        end
    end
    def show
        user = User.find_by(id: session[:user_id])
        # byebug
        if user
            render json: user, status: :ok
        else
            render json: {error: "Unauthorized request"}, status: :unauthorized
        end
        
    end

    private
    def user_params
        params.permit(:username, :email, :password)
    end
end
