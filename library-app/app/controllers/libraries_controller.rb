class LibrariesController < ApplicationController

    def show
        @library = Library.find(params[:id])
    end

    def new
        @library = Library.new
        5.times do
         @library.books.build
        end
    end

    def create
        @library = Library.new(library_params)
        @library.user = current_user
        @library.save
        if @library.save
            redirect_to library_path(@library)
        else
            render new_library_path
        end
    end

    def edit 
        @library = Library.find(params[:id])
    end

    def update
        @library = Library.find(params[:id])
        @library.update(library_params)
        redirect_to library_path(@library)
    end

    def destroy
        @library = Library.find(params[:id])
        @new = Library.find_by(name: "New")
        @new.books << @library.books
        @library.destroy
        redirect_to user_path(current_user)
    end
    
    private
    def library_params
        params.require(:library).permit(
            :name,
            books_attributes: [
                :title,
                :language
            ]
        )
    end
end
