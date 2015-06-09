class SystemBooking < ActiveRecord::Base
  belongs_to :system
  belongs_to :member

  before_validation :create_price

  validates :install_date, :collection_date, presence: true

  validate :price_not_negative
  validate :starts_in_future
  validate :ends_after_start
  validate :system_not_booked

  def price_not_negative
    if self.total_cost
      if self.total_cost < 0
        errors.add(:total_cost, 'Price cannot be below 0')
      end
    end
  end

  def starts_in_future
    if self.install_date
      unless (self.install_date+1.days).future?
        errors.add(:install_date, 'Booking cannot start in the past')
      end
    end
  end

  def ends_after_start
    if self.collection_date and self.install_date
      unless self.collection_date > self.install_date
        errors.add(:collection_date, 'Booking must finish after it starts')
      end
    end
  end

  def self.search(search)
    found_systems = []
    all_systems = System.all()
    criteria = search.split(' ')
    criteria.each do |c|
      all_systems.each do |s|
        if s.description.downcase.include? c.downcase or s.audio_setup.to_s.include? c or s.id.to_s == c
          found_systems.append(s)
        end
      end
    end
    return found_systems
  end

  def create_price
    if self.collection_date and self.install_date
      days = self.collection_date - self.install_date
      self.total_cost = days*self.system.base_price
    end
  end

  def system_not_booked
    unless system_not_booked_checker
      errors.add(:install_date, 'System is already booked at this time')
    end
  end

  def system_not_booked_checker
    bookings = SystemBooking.where('install_date >= :today AND system_id = :system AND id <> :id',today: Date.today, system: self.system_id, id: self.id)
    bookings.each do |book|
      if book.install_date == self.install_date
        return false
      elsif self.install_date > book.install_date and self.install_date < book.collection_date
        return false
      elsif self.install_date < book.install_date and self.collection_date > book.collection_date
        return false
      else
        return true
      end
    end
  end

  def self.due_today
    bookings = SystemBooking.where('install_date = :today',today: Date.today)
    return bookings
  end
end
