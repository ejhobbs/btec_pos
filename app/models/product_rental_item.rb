class ProductRentalItem < ActiveRecord::Base
  belongs_to :product_rental
  belongs_to :product

  validates :product_rental_id, :product_id, presence: true
  validates :id, uniqueness: true
end
