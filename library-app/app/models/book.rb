class Book < ApplicationRecord
    has_many :library_books
    has_many :libraries, through: :library_books
    belongs_to :author
    belongs_to :user, through: :libraries

    def author_attributes=(author)
        names = author.split(" ")
        if names.count > 1
            first_name = names[0..-2].join(" ")
            last_name = names.last
        else
            first_name = ""
            last_name = names
        end
        self.author = Author.find_or_create_by(first_name: first_name, last_name: last_name)
        self.save
    end

end
