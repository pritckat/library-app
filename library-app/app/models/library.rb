class Library < ApplicationRecord
    belongs_to :user
    has_many :library_books
    has_many :books, through: :library_books
    accepts_nested_attributes_for :books, reject_if: :all_blank

    LIST = ["Unsorted", "Books I've Loaned", "Books Loaned to Me"]

    def self.mandatory
        LIST
    end

    def Library.uncategorized_books
        LIST[0]
    end

    def Library.books_user_is_loaning
        LIST[1]
    end

    def Library.books_loaned_to_user
        LIST[2]
    end

    def remove_empty_books
        self.books.each do |book|
            if book.title == ""
                book.delete
            end
        end
    end
end
