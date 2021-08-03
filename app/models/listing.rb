class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :platform
end
