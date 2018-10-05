class Book < ApplicationRecord
    has_many :library_books
    has_many :libraries, through: :library_books
    has_many :book_authors
    has_many :authors, through: :book_authors
    accepts_nested_attributes_for :authors

    def author_attributes=(author)
        names = author.split(" ")
        first_name = names.first
        last_name = names.last
        self.authors << Author.find_or_create_by(first_name: first_name, last_name: last_name)
        self.save
    end

end
