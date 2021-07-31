class LoginsController < ApplicationController
    
    def login
        user = User.find_by(:email => params[:email])
        # byebug
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {errors: ["Invalid username or password"] }, status: :unauthorized
        end
    end
    
    def logout
        session.delete :user_id
        if session[:user_id] == nil
            render json: {messages: "Logged out"}
        else
            render json: {messages: "Failed"}
        end
    end

    private
    def login_params
        params.permit(:email, :password, :password_confirmation)
    end

end
