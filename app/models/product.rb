class Product < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :product_rental_item

  validates :name, :imdb_id, :age_rating, :star_rating, :synopsis, presence: true
  validates :age_rating, inclusion: { in: %w(U PG 12A 12 15 18 R18), message: '%{value} is not a valid rating'}
  validates :star_rating, numericality: true
  validates :id, uniqueness: true
  validate :star_rating_valid

  def star_rating_valid
    if self.star_rating
      if self.star_rating > 10 or self.star_rating < 0
        errors.add(:star_rating, 'Star rating must be between 0 and 10')
      end
    end
  end

  def self.search(search)
    found_products = []
    all_products = Product.all()
    criteria = search.split(' ')
    criteria.each do |c|
      all_products.each do |s|
        if s.name.downcase.include? c.downcase or s.product_type.easy_name.downcase.include? c.downcase or s.imdb_id.include? c.downcase or s.age_rating.downcase.include? c.downcase or s.synopsis.downcase.include? c.downcase or s.id.to_s == c or s.star_rating == c
          found_products.append(s)
        end
      end
    end
    return found_products
  end

  def self.from_csv(file)
    require 'csv'
    csv = CSV.parse(file.read, :headers => true)
    products = []
    failed_products = []
    csv.each do |row|
      products.append(Product.new(row.to_hash))
    end
    products.each do |sys|
      if sys.valid?
        sys.save
      else
        failed_products.append(sys)
      end
    end
    return failed_products
  end

end
