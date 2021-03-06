class Book < ApplicationRecord
    has_many :library_books
    has_many :libraries, through: :library_books
    belongs_to :author, optional: true
    has_many :users, through: :libraries

    validates :title, presence: true
    
    def author_attributes=(author)
        names = author.split(" ")
        if names.count > 1
            first_name = names[0..-2].join(" ")
            last_name = names.last
        elsif author.strip == ""
            first_name = ""
            last_name = "None"
        else
            first_name = ""
            last_name = names.join
        end
        self.author = Author.find_or_create_by(first_name: first_name, last_name: last_name)
        self.save
    end

    def loanee_name
        user = User.find_by(id: self.loaned_to)
        user.username
    end

end
