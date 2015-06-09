class System < ActiveRecord::Base
  has_many :system_booking

  validates :description, :audio_setup, :base_price, presence: true
  validates :audio_setup, :base_price, numericality: true
  validates :id, uniqueness: true
  validate :price_not_negative

  def price_not_negative
    if self.base_price
      if self.base_price < 0
        errors.add(:base_price, 'Price cannot be negative')
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

  def self.from_csv(file)
    require 'csv'
    csv = CSV.parse(file.read, :headers => true)
    systems = []
    failed_systems = []
    csv.each do |row|
      systems.append(System.new(row.to_hash))
    end
    systems.each do |sys|
      if sys.valid?
        sys.save
      else
        failed_systems.append(sys)
      end
    end
    return failed_systems
  end
end
