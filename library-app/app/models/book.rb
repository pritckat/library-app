class Book < ApplicationRecord
    has_many :library_books
    has_many :libraries, through: :library_books
    has_many :book_authors
    has_many :authors, through: :book_authors


    def author_names
        self.authors.first.full_name
    end
end
