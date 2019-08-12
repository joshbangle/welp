class Place < ApplicationRecord
    paginates_per 10

    belongs_to :user
    has_many :comments
    has_many :photos
    
    geocoded_by :address
    after_validation :geocode
    
    validates :name, :address, :description, presence: true

    
end
