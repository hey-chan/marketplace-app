class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :platform
  enum condition: {poor: 0, acceptable: 1, good: 2, great: 3, mint: 4}
  has_one_attached :picture
  has_one :order, dependent: :destroy

  before_save :remove_whitespace
  before_save :convert_to_cents, if: :price_changed?

  private
  def remove_whitespace
    self.title = self.title.strip
    self.description = self.description.strip
  end

  def convert_to_cents
    self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
  end
end
