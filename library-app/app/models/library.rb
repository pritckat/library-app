class Library < ApplicationRecord
    belongs_to :user
    has_many :library_books
    has_many :books, through: :library_books
    accepts_nested_attributes_for :books

    def remove_empty_books
        self.books.each do |book|
            if book.title == ""
                book.delete
            end
        end
    end
end
