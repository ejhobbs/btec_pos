class MemberType < ActiveRecord::Base
  validates :easy_name, :price, presence: true
  validates :price, numericality: true
  validates :id, uniqueness: true
  validate :positive_price

  def positive_price
    if self.price
      if self.price < 0
        errors.add(:price, 'Price cannot be less than 0')
      end
    end
  end

  def self.search(search)
    found_types = []
    all_types = MemberType.all()
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
      types.append(MemberType.new(row.to_hash))
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
