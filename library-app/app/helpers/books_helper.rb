module BooksHelper

    def author_names(book)
        if book.authors.count == 1
            book.authors.first.full_name
        else 
            names = book.authors.map { |a| a.full_name }
            names.join(", ")
        end
    end

end
