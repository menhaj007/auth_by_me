class BooksController < ApplicationController

    def create
        current_user = User.find_by(id: session[:user_id])
        if current_user
            new_book = Book.create(title: params[:title], published: params[:published], user_id: current_user.id)
            
            if new_book.valid?
                render :json => new_book, status: :created
            else
                render :json => {error: "Failed to create a book"}, status: :unprocessable_entity
            end
                
        else
            render :json => {error: "Please login first"}, status: :unauthorized
        end
    end
    def show
        user = User.find_by(id: session[:user_id])
        if user
            render :json => user, include: [:books], status: :ok
        else
            render :json => {error: "Longin first"}, status: :unauthorized
        end
    end

    private
    def book_params
        # params.user_id = session[:user_id]
        params.permit(:title, :published)
    end
end
