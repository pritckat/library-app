class User < ApplicationRecord
    has_secure_password
    has_many :libraries
    has_many :books, through: :libraries
    validates :username, presence: :true
    validates :username, uniqueness: true

end
