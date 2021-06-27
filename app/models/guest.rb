class Guest < ApplicationRecord
    serialize :phone, Array
    validates :email, uniqueness: true
    has_many :reservations
    
    def to_json
        {
            id: id,
            email: email,
            first_name: first_name,
            last_name: last_name,
            phone: phone
        }

    end
end