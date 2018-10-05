class Book < ApplicationRecord
    has_many :library_books
    has_many :libraries, through: :library_books
    belongs_to :author

    def author_attributes=(author)
        names = author.split(" ")
        first_name = names.first
        last_name = names.last
        self.author = Author.find_or_create_by(first_name: first_name, last_name: last_name)
        self.save
    end

end
