class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :platform
  belongs_to :condition
  has_one_attached :picture
  has_one :order, dependent: :destroy

  # Form field validation
  validates :title, :condition, :price, :description, presence: true

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
