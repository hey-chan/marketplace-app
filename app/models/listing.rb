class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :platform
  enum condition: {poor: 0, acceptable: 1, good: 2, great: 3, mint: 4}
end
