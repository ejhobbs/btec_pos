class ProductRental < ActiveRecord::Base
  has_many :product_rental_items
  belongs_to :member

  validates :member_id, :start_date, :due_date, :total_price, :late_fees, presence: true
  validates :id, uniqueness: true
  validate :price_not_negative
  validate :starts_in_future
  validate :ends_after_start

  def self.search(search)
    found_product_rentals = []
    all_product_rentals = ProductRental.all()
    criteria = search.split(' ')
    criteria.each do |c|
      all_product_rentals.each do |s|
        if s.id.to_s == c or s.member.id.to_s == c or s.member.first_name.downcase.include? c or s.member.surname.downcase.include? c
          found_product_rentals.append(s)
        end
      end
    end
    return found_product_rentals
  end

  def price_not_negative
    if self.total_price
      if self.total_price < 0
        errors.add(:total_price, 'Price cannot be below 0')
      end
    end
  end

  def starts_in_future
    if self.start_date
      unless (self.start_date+1.days).future?
        errors.add(:start_date, 'Rental cannot start in the past')
      end
    end
  end

  def ends_after_start
    if self.due_date and self.start_date
      unless self.due_date > self.start_date
        errors.add(:end_date, 'Rental must finish after it starts')
      end
    end
  end

  def duration
    self.due_date - self.start_date
  end

  def overdue
    if self.due_date.past?
      return true
    else
      return false
    end
  end
end
