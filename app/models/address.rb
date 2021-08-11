class Address < ApplicationRecord
  belongs_to :user
  validates :street_name, :suburb, :postcode, :state, :country, presence: true
end
