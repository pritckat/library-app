module BooksHelper

    def author_names
        self.authors.each do |a|
            "#{a.first_name} #{a.last_name}" 
        end
    end
end
