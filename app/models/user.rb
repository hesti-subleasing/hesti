class User < ApplicationRecord
    has_many :listings
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    attr_accessor :password_confirmation
end
