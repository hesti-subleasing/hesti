class User < ApplicationRecord
    has_many :listings
    has_many :listings, :through => :favorite
    has_many :listings, :through => :request
    # belongs_to :organization
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    attr_accessor :password_confirmation
end
