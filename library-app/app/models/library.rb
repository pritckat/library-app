class Library < ApplicationRecord
    belongs_to :user
    has_many :library_books
    has_many :books, through: :library_books
    accepts_nested_attributes_for :books
end
