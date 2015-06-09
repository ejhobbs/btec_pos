class ProductType < ActiveRecord::Base
  has_many :products, :dependent => :destroy

  validates :easy_name, :price, presence: true
  validates :id, uniqueness: true
  validate :price_not_negative

  def price_not_negative
    if self.price
      if self.price < 0
        errors.add(:price, 'Price cannot be negative')
      end
    end
  end

  def self.search(search)
    found_types = []
    all_types = ProductType.all()
    criteria = search.split(' ')
    criteria.each do |c|
      all_types.each do |s|
        if s.easy_name.downcase.include? c.downcase or s.price == c or s.id.to_s == c
          found_types.append(s)
        end
      end
    end
    return found_types
  end

  def self.from_csv(file)
    require 'csv'
    csv = CSV.parse(file.read, :headers => true)
    types = []
    failed_types = []
    csv.each do |row|
      types.append(ProductType.new(row.to_hash))
    end
    types.each do |sys|
      if sys.valid?
        sys.save
      else
        failed_types.append(sys)
      end
    end
    return failed_types
  end
end
