class BooksController < ApplicationController

    def show
        @book = Book.find(params[:id])
    end
    
    def new
        @book = Book.new
        if params[:library_id]
            @library = Library.find(params[:library_id])
        else
            flash.alert = "Please pick the library you would like to add a book to, or create a new library."
            redirect_to user_path(current_user)
        end
    end

    def create
        @book = Book.create(book_params)
        if params[:library_id]
            @book.libraries << Library.find(params[:library_id])
        end
        redirect_to book_path(@book)
    end

    private

    def book_params
        params.require(:book).permit(:title, :language)
    end
end
