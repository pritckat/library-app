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
        @user = current_user
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
        @user = User.find_by(id: params[:book][:loaned_to])
        @book.loaned_to = @user.id
        @book.loaned = true
        lib = Library.find_by(name: "On Loan", user_id: current_user)
        lib2 = Library.find_by(name: "Loaned", user_id: @user.id)
        lib.books << @book
        lib2.books << @book
        @book.save
        lib.save
        lib2.save
        redirect_to book_path(@book)
    end

    def return
        @book = Book.find(params[:id])
        @book.loaned = false
        lib = Library.find_by(name: "Loaned", user: current_user)
        lib2 = Library.find_by(name: "On Loan", user: @book.users.first)
        lib.books.delete(@book)
        lib2.books.delete(@book)
        lib.save
        lib2.save
        @book.save
        redirect_to library_path(lib)
    end

    private

    def book_params
        params.require(:book).permit(
            :title, :language, :library_ids => []
        )
    end
end
