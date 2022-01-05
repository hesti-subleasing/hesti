class User < ApplicationRecord
    has_many :listings
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :username, presence: true
    validates :email, presence: true
    validates :password, presence: true
end
