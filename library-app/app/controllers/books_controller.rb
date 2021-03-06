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
            if @library.user != current_user
                flash.alert = "You cannot place books in other people's libraries."
                redirect_to library_path(@library)
            end
        else
            flash.alert = "Please pick the library you would like to add a book to, or create a new library."
            redirect_to user_path(current_user)
        end
    end

    def create
        #raise params
        @book = Book.new(book_params)
        @book.author_attributes=(params[:book][:author])
        @book.owned_by = current_user.id
        @book.save
        if params[:library_id]
            @book.libraries << Library.find(params[:library_id])
        end
        redirect_to book_path(@book)
    end

    def edit
        @book = Book.find(params[:id])
        @user = current_user
        if @book.users.first != current_user
            flash.alert = "You cannot edit other people's books."
            redirect_to book_path(@book)
        end
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
        if @book.owned_by != current_user.id
            flash.alert = "You cannot loan another person's book."
            redirect_to book_path(@book)
        elsif @book.loaned == true
            flash.alert = "This book is already loaned to #{@book.loanee_name}"
            render book_path(@book)
        end
    end

    def loaned
        @book = Book.find(params[:id])
        @user = User.find_by(id: params[:book][:loaned_to])
        @book.loaned_to = @user.id
        @book.loaned = true
        lib = Library.find_by(name: Library.books_user_is_loaning, user_id: current_user)
        lib2 = Library.find_by(name: Library.books_loaned_to_user, user_id: @user.id)
        lib.books << @book
        lib2.books << @book
        @book.save
        lib.save
        lib2.save
        redirect_to book_path(@book)
    end

    def return
        @book = Book.find(params[:id])
        if @book.loaned_to != current_user.id
            flash.alert "This book is not loaned to you."
            redirect_to book_path(@book)
        end
        @book.loaned = false
        owner = User.find(@book.owned_by)
        lib = Library.find_by(name: Library.books_loaned_to_user, user: current_user)
        lib2 = Library.find_by(name: Library.books_user_is_loaning, user: owner)
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
