class BooksController < ApplicationController

    def index
        if params[:user_id]
            @user = User.find(params[:user_id])
            @books = @user.books
        else
            @books = Book.all 
    
        end
    end
    
    def show
        @book = Book.find(params[:id])
        @loaned = User.find_by(id: @book.loaned_to)
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
        #raise params
        @book = Book.create(book_params)
        @book.author_attributes=(params[:book][:author])
        if params[:library_id]
            @book.libraries << Library.find(params[:library_id])
        end
        redirect_to book_path(@book)
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        @book.update(book_params)
        @book.author_attributes=(params[:book][:author])
        redirect_to book_path(@book)
    end

    def destroy
        Book.find(params[:id]).destroy
        redirect_to user_path(current_user)
    end

    def loan
        @book = Book.find(params[:id])
    end

    def loaned
        @book = Book.find(params[:id])
        @user = User.find_by(username: params[:book][:loaned_to])
        @book.loaned_to = @user.id
        @book.loaned = true
        @book.save
        #raise params
        redirect_to book_path(@book)
    end

    private

    def book_params
        params.require(:book).permit(
            :title, :language
        )
    end
end
