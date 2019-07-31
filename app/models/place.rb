class Place < ApplicationRecord
    paginates_per 5

    belongs_to :user
    validates :name, :address, :description, presence: true
  
end
