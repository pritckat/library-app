module LibrariesHelper

    def books_on_loan(user)
        books = []
        user.books.map do |book|
            if book.loaned == true
                books << book.title
            end
        end
        books
    end

    def loaned_to_me(user)
        # books = []
        # Book.all.map do |book|
        #     if book.loaned_to == user.id
        #         books << book.title
        #     end
        # end
        # books
        "hello"
    end
end
