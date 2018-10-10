class User < ApplicationRecord
    has_secure_password
    has_many :libraries
    has_many :books, through: :libraries
    validates :username, presence: :true
    validates :username, uniqueness: true

    def non_mandatory_libraries
        libs = []
        self.libraries.each do |lib|
            if !Library.mandatory.include?(lib.name)
                libs << lib
            end
        end
        libs
    end

end
